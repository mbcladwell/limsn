#!/bin/sh



# We require Bash but for portability we'd rather not use /bin/bash or
# /usr/bin/env in the shebang, hence this hack.
if [ "x$BASH_VERSION" = "x" ]
then
    exec bash "$0" "$@"
fi

# set -e

# [ "$UID" -eq 0 ] || { echo "This script must be run as root."; exit 1; }


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


updatesys()
{
    sudo DEBIAN_FRONTEND=noninteractive apt-get --assume-yes update
    sudo DEBIAN_FRONTEND=noninteractive apt-get --assume-yes upgrade
    sudo DEBIAN_FRONTEND=noninteractive apt-get  --assume-yes install texinfo ca-certificates postgresql postgresql-client postgresql-contrib libpq-dev git nano zlib1g-dev libnss3 libnss3-dev libgmp-dev libgc-dev libffi-dev libltdl-dev libintl-perl libiconv-hook-dev nettle-dev 
  
}

initdb()
{
    _msg "configuring db"
    mkdir /home/admin/projects
    cd /home/admin/projects
    git clone --depth 1 git://github.com/mbcladwell/limsn.git 

    sudo chmod -R a=rwx /home/admin/projects/limsn

    PGMAJOR=$(eval "ls /etc/postgresql")
    PGHBACONF="/etc/postgresql/$PGMAJOR/main/pg_hba.conf"
    sudo sed -i 's/host[ ]*all[ ]*all[ ]*127.0.0.1\/32[ ]*md5/host    all        all             127.0.0.1\/32        trust/' $PGHBACONF

    PGCONF="/etc/postgresql/$PGMAJOR/main/postgresql.conf"
    sudo sed -i 's/\#listen_addresses =/listen_addresses =/' $PGCONF

    eval "sudo pg_ctlcluster $PGMAJOR main restart"
 #   psql -U postgres -h 127.0.0.1 -a -f /home/admin/projects/limsn/limsn/postgres/initdb.sql
 #   psql -U ln_admin -h 127.0.0.1 -d lndb -a -f /home/admin/projects/limsn/limsn/postgres/create-db.sql
 #   psql -U ln_admin -h 127.0.0.1 -d lndb -a -f /home/admin/projects/limsn/limsn/postgres/example-data.sql
    
    
}


configure()
{
    touch ~/.bash_profile
    
    echo "export PATH=\"$PATH:/usr/local/bin\"" >> ~/.bash_profile   ## for art
  #  echo "export GUILE_LOAD_PATH=\"/usr/share/guile/site/3.0:/limsn:/usr/local/share/guile/site/2.2${GUILE_LOAD_PATH:+:}$GUILE_LOAD_PATH\"" >> ~/.bash_profile  
  #  echo "export GUILE_LOAD_COMPILED_PATH=\"/usr/lib/x86_64-linux-gnu/guile/3.0/site-ccache:/usr/lib/guile/3.0/site-ccache:/usr/lib/x86_64-linux-gnu/guile/2.2/site-ccache${GUILE_LOAD_COMPILED_PATH:+:}$GUILE_LOAD_COMPILED_PATH\"" >> ~/.bash_profile


    
}


main()
{
    local tmp_path
    welcome
    export DEBIAN_FRONTEND=noninteractive 
    _msg "Starting installation ($(date))"
    
    updatesys
    configure
    initdb
    
    _msg "${INF}cleaning up ${tmp_path}"
    rm -r "${tmp_path}"

    _msg "${PAS}LIMS*Nucleus has successfully been installed!"

    # Required to source /etc/profile in desktop environments.
    _msg "${INF}Run 'nohup ~/run-limsn.sh &' to start the server in detached mode."
 }

main "$@"
