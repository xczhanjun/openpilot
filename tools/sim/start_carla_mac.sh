#!/bin/bash

if [[  "$WIT_BUILD"  ]]; then
  docker build -t witcarla/carla:wit -t registry.tongxin.cn/witcarla/carla:wit -f Dockerfile.sim_mac .
  docker push registry.tongxin.cn/witcarla/carla:wit
else
  docker pull registry.tongxin.cn/witcarla/carla:wit
fi

EXTRA_ARGS="-it"
if [[ "$DETACH" ]]; then
  EXTRA_ARGS="-d"
fi

export HOSTNAME=`hostname`
xhost + ${hostname}
# --net host 
docker kill carla_sim || true
docker run \
  --name carla_sim \
  --rm \
  -p 2000:2000 -p 2001:2001 -p 2002:2002 \
  -e DISPLAY=${HOSTNAME}:0 \
  --env=QT_X11_NO_MITSHM=1 \
  --env=XAUTHORITY=/home/carla/.Xauthority \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  $EXTRA_ARGS \
  registry.tongxin.cn/witcarla/carla:wit \
  /bin/bash ./CarlaUE4.sh  -nosound -RenderOffScreen -benchmark -fps=20 -quality-level=Low
