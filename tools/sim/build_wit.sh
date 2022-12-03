#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sim_img="registry.tongxin.cn/witpilot-pub/openpilot-sim:latest"
docker pull $sim_img

docker build \
  --cache-from $sim_img \
  -t registry.tongxin.cn/witpilot-pub/openpilot-sim-wit:latest \
  -f Dockerfile.sim_wit .

docker push registry.tongxin.cn/witpilot-pub/openpilot-sim-wit:latest
