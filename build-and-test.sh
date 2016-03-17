#!/bin/sh

rm -rf /tmp/rr-*
rm -rf ~/tmp
mkdir ~/tmp
rm -rf ~/rr/obj
mkdir ~/rr/obj
cd ~/rr/obj
cmake ../rr
make -j8 -C ~/rr/obj
make -j8 -C ~/rr/obj check
rm -rf ~/.local/share/rr/*
(rm -rf ~/tmp/firefox-profile ; mkdir ~/tmp/firefox-profile ; ~/rr/rr-vm-testing/xvnc-runner.sh "firefox --profile $HOME/tmp/firefox-profile $HOME/rr/rr-vm-testing/test.html" "rr Test Page")
(rm -rf ~/.config/libreoffice ; ~/rr/rr-vm-testing/xvnc-runner.sh "libreoffice $HOME/rr/rr-vm-testing/rr-test-doc.odt" "rr-test-doc.odt")
