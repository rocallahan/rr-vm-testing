#!/bin/bash

CMD=$1
EXPECT=$2

rm -f ~/tmp/xvnc ~/tmp/xvnc-client ~/tmp/xvnc-wininfo ~/tmp/xvnc-client-replay

Xvnc :9 > ~/tmp/xvnc 2>&1 &
until grep -q "Listening" ~/tmp/xvnc; do
  sleep 1
done
DISPLAY=:9 ~/rr/obj/bin/rr $CMD > ~/tmp/xvnc-client 2>&1 &
DISPLAY=:9 xwininfo -tree -root > ~/tmp/xvnc-wininfo 2>&1
until grep -q "$EXPECT" ~/tmp/xvnc-wininfo; do
  sleep 1
  DISPLAY=:9 xwininfo -tree -root > ~/tmp/xvnc-wininfo 2>&1
done
kill %1
wait %2
~/rr/obj/bin/rr replay -a > ~/tmp/xvnc-client-replay 2>&1
if [[ $? != 0 ]]; then
  echo FAILED: replay failed
  exit 1
fi
diff ~/tmp/xvnc-client ~/tmp/xvnc-client-replay
if [[ $? != 0 ]]; then
  echo FAILED: replay differs
  exit 1
fi
echo PASSED: $CMD
exit 0
