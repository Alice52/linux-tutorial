## install

  ```shell
  # method 01: it is slow
  sudo curl -L https://get.daocloud.io/docker/compose/releases/download/1.25.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose

  # method 02: it can be install by pip
  pip[3] install --upgrade pip
  pip[3] uninstall docker-compose
  ```

## **Config**

1.  Dockerfile

    - The config which contains the Commands to build docker image

2. DockerCompose

  - Define a process to build the docker services, and the config of these docker services

## **Component**

1. Docker Image

   - The template of docker container, it is the docker container's set of file

2. Docker Container

   - The instance of docker image, which can be run or stop

3. Docker Repository
   - The repository of docker images, such as docker hub, we can upload, download images from docker repository

## **Common Command**

1. docker images: show the list of local images
2. docker build: build docker image
3. docker tag: tag the docker images, help to manage images
4. docker rmi <imageId/imageName>: delete the dock image
5. docker ps: show the list of running docker containers, use 'docker ps -a' to show the list of all the docer contains
6. docker start/stop/restart <containerId/containerName>: start/stop/restart container
7. docker rm <containerId/containerName>: delete docker container
8. docker-compose `-f xx.yaml` up <service name>: build and start the docker services
9. docker-compose down <service name>: stop and remove the docker services
10. docker-compose start <service name>: start the docker services
11. docker-compose stop <service name>: stop the docker services

---

## reference

1. [docker-compose](https://docs.docker.com/compose/install/)
2. [version](https://docs.docker.com/compose/compose-file/compose-versioning/)
