#!/bin/sh

rm -rf /tmp/rr-*
rm -rf ~/tmp
mkdir ~/tmp
rm -rf ~/rr/obj
mkdir ~/rr/obj
cd ~/rr/obj
cmake -DCMAKE_BUILD_TYPE=RELEASE -Dstaticlibs=TRUE -Dstrip=TRUE ../rr || exit
make -j8 -C ~/rr/obj || exit
make -j8 -C ~/rr/obj check || exit
rm -rf ~/.local/share/rr/*
(rm -rf ~/tmp/firefox-profile ; mkdir ~/tmp/firefox-profile ; ~/rr/rr-vm-testing/xvnc-runner.sh "firefox --profile $HOME/tmp/firefox-profile $HOME/rr/rr-vm-testing/test.html" "rr Test Page") || exit
(rm -rf ~/.config/libreoffice ~/rr/rr-vm-testing/.~lock* ; ~/rr/rr-vm-testing/xvnc-runner.sh "libreoffice $HOME/rr/rr-vm-testing/rr-test-doc.odt" "rr-test-doc.odt") || exit
