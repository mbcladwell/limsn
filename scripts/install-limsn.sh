#!/bin/sh

# http://hayne.net/MacDev/Notes/unixFAQ.html#shellStartup
# We require Bash but for portability we'd rather not use /bin/bash or
# /usr/bin/env in the shebang, hence this hack.
if [ "x$BASH_VERSION" = "x" ]
then
    exec bash "$0" "$@"
fi

PAS=$'[ \033[32;1mPASS\033[0m ] '
ERR=$'[ \033[31;1mFAIL\033[0m ] '
WAR=$'[ \033[33;1mWARN\033[0m ] '
INF="[ INFO ] "
# ------------------------------------------------------------------------------
#+UTILITIES

_err()
{ # All errors go to stderr.
    printf "[%s]: %s\n" "$(date +%s.%3N)" "$1"
}

_msg()
{ # Default message to stdout.
    printf "[%s]: %s\n" "$(date +%s.%3N)" "$1"
}

_debug()
{
    if [ "${DEBUG}" = '1' ]; then
        printf "[%s]: %s\n" "$(date +%s.%3N)" "$1"
    fi
}

# Return true if user answered yes, false otherwise.
# $1: The prompt question.
prompt_yes_no() {
    while true; do
        read -rp "$1" yn
        case $yn in
            [Yy]*) return 0;;
            [Nn]*) return 1;;
            *) _msg "Please answer yes or no."
        esac
    done
}

welcome()
{
    cat<<"EOF"

 _______________________  |  _ |_  _  _ _ _|_ _  _         
|O O O O O O O O O O O O| |_(_||_)(_)| (_| | (_)| \/       
|O O O O O O 1 O O O O O|                         /        
|O O O O O O O O O O O O|  /\    _|_ _  _ _  _ _|_. _  _   
|O O O O O O O O O O O O| /~~\|_| | (_)| | |(_| | |(_)| |  
|O O 1 O O O O O 1 O 1 O|  _                               
|O O O O O O O O O O O O| (  _ |   _|_. _  _  _            
|O O O 1 O O O O O O O O| _)(_)||_| | |(_)| |_)    
|O O O O O O O O O O O O|
 -----------------------  info@labsolns.com

This script installs LIMS*Nucleus on your system

http://www.labsolns.com

EOF
    echo -n "Press return to continue..."
    read -r
}


query()
{
    echo Enter IP address:
    read IPADDRESS
    
    echo Maximum number of plates per plate set:
    read MAXNUMPLATES


}


updatesys()
{

sudo DEBIAN_FRONTEND=noninteractive apt-get --assume-yes update
sudo DEBIAN_FRONTEND=noninteractive apt-get  --assume-yes install gnupg git nscd postgresql-client
wget 'https://sv.gnu.org/people/viewgpg.php?user_id=15145' -qO - | sudo -i gpg --import -
wget 'https://sv.gnu.org/people/viewgpg.php?user_id=127547' -qO - | sudo -i gpg --import -
    
  
}

installguix()
{

git clone --depth 1 https://github.com/mbcladwell/limsn.git

sed -i "s/host.name = 127.0.0.1/host.name = $IPADDRESS/" /home/admin/limsn/limsn/conf/artanis.conf
sed -i "s/cookie.maxplates = 10/cookie.maxplates = $MAXNUMPLATES/" /home/admin/limsn/limsn/conf/artanis.conf

 sudo ./limsn/scripts/guix-install-mod.sh
source /home/admin/.guix-profile/etc/profile 


## using guile-3.0.2
guix install glibc-utf8-locales guile-dbi postgresql@13.1 gnuplot
sudo guix install glibc-utf8-locales
    
# After setting `PATH', run `hash guix' to make sure your shell refers to `/home/admin/.config/guix/current/bin/guix'.
#$ echo $PATH
#/home/admin/.config/guix/current/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
         
             
guix package --install-from-file=/home/admin/limsn/scripts/artanis51.scm

}

initdb()
{
    _msg "configuring db"


mkdir lndata

echo "export PGDATA=\"/home/admin/lndata\"" >> /home/admin/.bashrc
export PGDATA="/home/admin/lndata"


initdb -D /home/admin/lndata

cp /home/admin/limsn/limsn/postgres/pg_hba.conf /home/admin/lndata
cp /home/admin/limsn/limsn/postgres/pg_ident.conf /home/admin/lndata
cp /home/admin/limsn/limsn/postgres/postgresql.conf /home/admin/lndata

pg_ctl -D /home/admin/lndata -l logfile start

psql -U admin -h 127.0.0.1 postgres -a -f /home/admin/limsn/limsn/postgres/initdba.sql
psql -U admin -h 127.0.0.1 lndb -a -f /home/admin/limsn/limsn/postgres/initdbb.sql
psql -U ln_admin -h 127.0.0.1 -d lndb -a -f /home/admin/limsn/limsn/postgres/create-db.sql
psql -U ln_admin -h 127.0.0.1 -d lndb -a -f /home/admin/limsn/limsn/postgres/example-data.sql

    
}


configure()
{

echo "export GUIX_PROFILE=\"/home/admin/.guix-profile\"" >> /home/admin/.bashrc
echo " . \"/home/admin/.guix-profile/etc/profile\"" >> /home/admin/.bashrc
echo "export LC_ALL=\"C\"" >> /home/admin/.bashrc
echo "export GUIX_LOCPATH=\"$HOME/.guix-profile/lib/locale\"" >> /home/admin/.bashrc


export GUIX_PROFILE="/home/admin/.guix-profile"
export LC_ALL="C"
export GUIX_LOCPATH="$HOME/.guix-profile/lib/locale" 

    touch ~/run-limsn.sh
    echo "cd ~/limsn/limsn" >> ~/run-limsn.sh
    echo "art work -h 0.0.0.0" >> ~/run-limsn.sh
    chmod 777 ~/run-limsn.sh
    
}


main()
{
    local tmp_path
    welcome
    export DEBIAN_FRONTEND=noninteractive 
    _msg "Starting installation ($(date))"
    
    query
    updatesys
    configure
    installguix
##    initdb
    cp /home/admin/limsn/scripts/install-lnpg.sh /home/admin    
    chmod 777 /home/admin/install-lnpg.sh
    source /home/admin/.guix-profile/etc/profile
    source /home/admin/.bashrc
    _msg "${INF}cleaning up ${tmp_path}"
    rm -r "${tmp_path}"

    _msg "${PAS}LIMS*Nucleus has successfully been installed!"

    # Required to source /etc/profile in desktop environments.
     _msg "${INF}Run './install-lnpg.sh' to install the database"
 }

## https://www.ubuntubuzz.com/2021/04/lets-try-guix.html

main "$@"
