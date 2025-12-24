#!/bin/bash

rm /tmp/.X99-lock
Xvfb :99 -screen 0 1920x1080x16 &
sleep 2
# -----------------------------------
echo 'alias lms="~/.cache/lm-studio/bin/lms"' > ~/.bashrc


/squashfs-root/lm-studio --no-sandbox &
sleep 30
~/.cache/lm-studio/bin/lms server start --cors &


sleep 5
### ~/.cache/lm-studio/bin/lms get ${MODEL_PATH}
##~/.cache/lm-studio/bin/lms load --gpu 0.3 --ttl 3600 --context-length ${CONTEXT_LENGTH:-16384} ${MODEL_IDENTIFIER} &
#~/.cache/lm-studio/bin/lms load  --ttl 3600 --context-length ${CONTEXT_LENGTH:-16384} ${MODEL_IDENTIFIER} &
for m in ${MODEL_IDENTIFIER} ; do
##~/.cache/lm-studio/bin/lms load  --ttl 3600 --context-length ${CONTEXT_LENGTH:-16384} $m &
~/.cache/lm-studio/bin/lms load ${GPU_USAGE:+ --gpu $GPU_USAGE} --ttl 60000 --context-length ${CONTEXT_LENGTH:-16384} -y $m
done

sleep 20

ln -sf ~/.cache/lm-studio/bin/lms /usr/local/bin/lms  ||:
cp -f /http-server-config.json /root/.cache/lm-studio/.internal/http-server-config.json
x11vnc -display :99 -forever -rfbauth /root/.vnc/passwd -quiet -listen 0.0.0.0 -xkb


### ???
/bin/bash
