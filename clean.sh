#!/bin/bash
rm ./ChangeLog
rm -Rf  ./build-aux
rm ./configure.ac
rm ./Makefile.am
rm ./pre-inst-env.in
rm ./guix.scm
rm ./hall.scm
rm ./*.go
rm ./limsn/*.go
rm ./scripts/*.*
rm ./limsn-0.1.tar.gz
rm ./limsn/lib/labsolns/*.go
rm ./limsn/app/api/*.go
rm ./limsn/app/controllers/*.go
hall init --convert --author "mbc" limsn --execute
hall scan -x
hall build -x
cp /home/mbc/syncd/tobedeleted/limsnaccessories/guix.scm .
cp /home/mbc/syncd/tobedeleted/limsnaccessories/hall.scm .
cp /home/mbc/syncd/tobedeleted/limsnaccessories/Makefile.am .
autoreconf -vif && ./configure && make
cp /home/mbc/syncd/tobedeleted/limsnaccessories/postgres/*.* ./limsn/postgres


cp /home/mbc/syncd/tobedeleted/limsnaccessories/scripts/*.sh ./scripts


make dist



##scp -i /home/mbc/labsolns.pem ./shinyln-0.1.tar.gz admin@ec2-18-189-31-114.us-east-2.compute.amazonaws.com:.
##scp -i /home/mbc/labsolns.pem /home/mbc/syncd/tobedeleted/shinyln/guix.scm admin@ec2-18-189-31-114.us-east-2.compute.amazonaws.com:.
##guix package --install-from-file=guix.scm
##source /home/mbc/.guix-profile/etc/profile
