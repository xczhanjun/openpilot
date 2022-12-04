#!/usr/bin/env bash

set -x

docker run \
  -u root --name jenkinsci \
  --rm \
  -d \
  -p 8080:8080 \
  -p 50000:50000 \
  -v ~/jenkins-data:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  jenkinsci/blueocean

