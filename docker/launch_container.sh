#!/bin/bash

xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f /tmp/.docker.xauth nmerge -


if [ "$1" = "cpu" ]; then
        gpu=""
else
        gpu="--gpus all"
fi

MY_PATH=$(dirname "")            # relative
MY_PATH=$(cd "$MY_PATH" && pwd)  # absolutized and normalized
if [[ -z "$MY_PATH" ]] ; then
  exit 1  # fail
fi
MY_PATH=$MY_PATH/
echo $MY_PATH
# Port-forwarding guide (Line 23):
# wonjae : 5000, dohyun: 5001, wonjoon: 5002
docker run -it --rm\
    --shm-size=8G \
    --ipc=host \
    --privileged $gpu \
    --hostname=$USER \
    --name metafarmers-ultralytics \
    -e XAUTHORITY=/tmp/.docker.xauth \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.docker.xauth:/tmp/.docker.xauth:rw \
    -v ${MY_PATH}/..:/workspace \
    -v /storage:/storage \
    metafarmers/ultralytics:latest
