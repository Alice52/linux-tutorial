## Docker: Build，Ship and Run Any App, Anywhere

### 1. docker introduce

1. elements

   - repository
   - mirror
     > 1. UnionFS: unite several directories into a single virtual filesystem
     > 2. layer and layer, bootfs + rootfs + ...
     > 3. docker image is dolwnload layer and layer
     > 4. layers structure to share resource

   ![avatar](/static/image/docker/docker-struct.png)

   - container

2. vm defect: which will analog hardware
   ![avatar](/static/image/docker/docker-vs-vm.jpg)

   - resource occupation
   - complicated process
   - slow start

3. linux container

   - not full system, just kernel and respective application and lib
   - container will isolate processors, low coupling
   - using shared kernel make it qiuck start

4. feat
   - faster application delivery and deployment
   - easier upgrades and expansions
   - simpler system operation and maintenance
   - more efficient use of computing resources, especially IO and memory
   - easier ci/cd

### 2. docker install and uninstall

1. [centos install](../linux/linux--centos.md#install-docker)
2. [ubuntu install](../linux/linux--ubuntu.md#docker)
3. docker content

   - config: `/etc/docker`
   - lib: `/var/lib/docker`
   - log: `/var/lib/docker/containers/CONTAINERID`

4. [centos uninstall](../linux/linux--centos.md#remove-docker)
5. [ubuntu uninstall](../linux/linux--ubuntu.md#uninstall)

### 3. common comand

1. docker common

   ```shell
   # 1. check version
   sudo docker version
   # 2. check info
   docker info
   # 3. auto start
   sudo systemctl enable docker
   # 4. docker container auto start
   docker update --restart=always 镜像ID
   # 5. docker container log
   sudo docker logs -f -t --tail 行数 容器名
   ```

2. docker image

   ```shell
   # 1. list images in host
   docker images
   # 2. list all images(including intermediate image layer)
   docker images -a
   # 3. only display mirror ID
   docker images -q
   # 4. display image summary info
   docker images --digests
   # 5. display full image info
   docker images --no-trunc

   # 6. remove specify mirror
   docker rmi MIRROR_ID
   # 7. remove mirrors
   docker rmi -f MIRROR_ID:TAG MIRROR_ID:TAG, MIRROR_ID:TAG MIRROR_ID:TAG
   # 8. remove all mirrors
   docker rmi -f $(docker images -qa)
   ```

3. docker search

   ```shell
   # 1. search specify mirror
   docker search MIRROR_ID
   # 2. search specify mirror with full info
   docker search MIRROR_ID --no-trunc
   # 3. search specify mirror and STARS more than NUMBER
   docker search MIRROR_ID -s NUMBER # START
   # 4. just search automated mirror
   docker search MIRROR_ID --automated
   ```

4. docker pull

   ```shell
   # 1. pull specify mirror
   docker pull MIRROR_ID
   # 2. pull specify mirror with version tag
   docker pull MIRROR_ID:VERSION_TAG
   ```

5. docker ps: look up containers

   ```shell
   ##############################################################################################
   ##   -a: list all currently running containers and history running containers               ##
   ##   -l: list recently created containers                                                   ##
   ##   -n: list the last n created containers                                                 ##
   ##   -q: just display CONTAINER_IS                                                          ##
   ##   --no-trunc: no truncate the output                                                     ##
   ##############################################################################################
   # 1. check running containers
   docker ps
   # 2. check all container
   docker ps -a
   ```

6. docker run: `docker run [OPTIONS] IMAGE [COMMAND] [ARG...]`

   ```shell
   ##############################################################################################
   ##   --name=CONTAINER_NAME                                                                  ##
   ##   -v: mount volume                                                                       ##
   ##   -e: transfer envrionment                                                               ##
   ##   -d: run in background and return the CONTAINER_ID, which is the daemon container       ##
   ##   -i: run in interactive mode, usually with -t                                           ##
   ##   -t: reassign a pseudo-input terminal for container, usually used with -i               ##
   ##   -P: random port mapping                                                                ##
   ##   -p: specify port mapping                                                               ##
   ##       ip:hostPort:containerPort                                                          ##
   ##       ip::containerPort                                                                  ##
   ##       hostPort:containerPort                                                             ##
   ##       containerPort                                                                      ##
   ##############################################################################################
   # 1. run container
   docker run ‐d ‐p 8888:8080 MIRROR_ID
   # 2. run container with mounted volume
   docker run ‐d ‐p 8888:8080 -v HOST_CONTENT:CONTAINER_CONTEXT MIRROR_ID
   # 3. run container with mounted volume adnd privilege
   docker run ‐d ‐p 8888:8080 -v HOST_CONTENT:CONTAINER_CONTEXT:to MIRROR_ID
   ```

7. docker container: container can be ommit

   ```shell
   # 1. stop specify container
   docker container stop CONTAINER_ID
   # 2. start specify container
   docker container start CONTAINER_ID
   # 3. restart specify container
   docker container restart CONTAINER_ID
   # 4. kill container
   docker container kill CONTAINER_ID

   # 5. remove specify container
   docker container rm CONTAINER_ID
   # 6. remove containers
   docker containers rm -f $(docker ps -a -q)
   docker container ps -a -q | xargs docker rm

   # 7. look up processor in specify container
   docker container top CONTAINER_ID
   # 8. container inject info
   docker container inject CONTAINER_ID

   # 9. look up specify container log
   docker container logs -f -t --tail ROW_NUMBER CONTAINER_ID
   docker logs --help
   # Options:
   #      --details        Show extra details provided to logs
   #  -f, --follow         Follow log output
   #      --since string   Show logs since timestamp (e.g. 2013-01-02T13:23:37) or relative (e.g. 42m for 42 minutes)
   #      --tail string    Number of lines to show from the end of the logs (default "all")
   #  -t, --timestamps     Show timestamps
   #     --until string   Show logs before a timestamp (e.g. 2013-01-02T13:23:37) or relative (e.g. 42m for 42 minutes)

   # 10. enter container
   # create new terminal
   docker container exec -it CONTAINER_ID /bin/bash # CTRL + P + Q
   # enter using terminal
   docker container attach CONTAINER_ID /bin/bash
   # 11. copy between host and container
   docker container cp example.war CONTAINER_ID:/usr/local/tomcat/webapps

   # 11. top
   docker top CONTAINER_ID

   # 12. stats
   docker stats [CONTAINER_ID]

   # 13. inspect
   docker inspect CONTAINER_ID
   ```

8. docker commit

   ```shell
   # CONTAINER_ID should be running
   docker commit -m="COMMIT_MESSSAGE" -a="AUTHOR" CONTAINER_ID TARGET_NAME:VTAG
   ```

### 4. : **`-v`**

1. function: durable data to disk, share data between host and container

   - `-v`: 会使用宿主机的内容覆盖容器的内容
   - `volumns`

     1. 如果宿主机目录不为空, 则使用现有文件进行挂载
     2. 如果宿主机目录为空, 则将容器内文件复制到宿主机

     |   不同点   |                   volumns                   |           -v           |
     | :--------: | :-----------------------------------------: | :--------------------: |
     |  文件位置  |       /var/lib/docker/在 volumes/xxx        | 可以是宿主机的任意位置 |
     | 挂载点影响 | 第一次启动时会容器内目录数据会复制到 volume |   宿主机文件覆盖容器   |
     | 单文件映射 |                  只能目录                   |       目录+文件        |
     |    权限    |                 读写或只读                  |       读写或只读       |
     |   移植行   |              强 在 volumes/下               |   弱(宿主机绝对路径)   |

2. command

   ```shell
   # 1. run container with mounted volume and container only read privilege
   docker run ‐d ‐p 8888:8080 -v HOST_CONTENT:CONTAINER_CONTEXT:to  --privileged=true MIRROR_ID
   ```

3. docker inject container_ID

   ```json
   "MountPoints": {
      "/var/lib/rabbitmq": {
        "Source": "/root/rabbitmq/data",
        "Destination": "/var/lib/rabbitmq",
        "RW": true,
        "Name": "",
        "Driver": "",
        "Type": "bind",
        "Propagation": "rprivate",
        "Spec": {
          "Type": "bind",
          "Source": "/root/rabbitmq/data",
          "Target": "/var/lib/rabbitmq"
        },
        "SkipMountpointCreation": false
      }
   }
   ```

4. volume container

   - type: 匿名挂载、具名挂载、指定路径挂载

     ```shell
     # 匿名挂载
     -v 容器内路径
     # 具名挂载
     -v 卷名:容器内路径
     # 指定路径挂载 docker volume ls 是查看不到的
     -v /宿主机路径:容器内路径
     ```

   - read and write

     ```shell
     # ro: readonly 只读
     docker run -d -P --name nginx05 -v juming:/etc/nginx:ro nginx
     # rw readwrite 可读可写
     docker run -d -P --name nginx05 -v juming:/etc/nginx:rw nginx
     ```

   - definition: 命名的容器挂载数据卷, 其它容器通过挂载这个(父容器)实现数据共享, 挂载数据卷的容器, 称之为数据卷容器
   - transfer data between containers

     ```shell
     # MIRROR_ID have defined volume, such as /zack
     # 1. run container01 with image
     docker run -it --name container01 MIRROR_ID
     # 2. run container02 with same image, and point parent volume
     docker run -it --name container02 --volumes-from container01 MIRROR_ID
     # 3. run container03 with same image, and point parent volume
     docker run -it --name container03 --volumes-from container01 MIRROR_ID
     # 4. run container04 with same image, and point parent volume
     docker run -it --name container03 --volumes-from container02 MIRROR_ID

     # now if created in file in container01:/zack, can get it in container02:/zack and container03:/zack and container04:/zack
     # now if created in file in container02:/zack, can get it in container01:/zack and container03:/zack and container04:/zack
     # now if created in file in container03:/zack, can get it in container01:/zack and container02:/zack and container04:/zack
     # now if created in file in container04:/zack, can get it in container01:/zack and container02:/zack and container03:/zack

     # 4. remove container01, no any effect
     docker rm -f container01 # stop and remove
     ```

### 5. DockerFile

- [DockerFile](./docker-file.md)

### 6. Docker 网络

1. 理解 Docker 0

   - 安装 docker 就会出现 `Docker 0`
   - 每启动一个 docker 容器, docker 就会给 docker 容器分配一个 ip, 我们只要按照了 docker, 就会有一个 docker0 桥接模式, 使用的技术是 `veth-pair` 技术

   - docker 容器带来网卡, 都是一对对的

   ![avatar](/static/image/docker/dokcer-container-network.png)

   - veth-pair 就是一对的虚拟设备接口, 他们都是成对出现的, 一端连着协议, 一端彼此相连
   - 正因为有这个特性 veth-pair 充当一个桥梁, 连接各种虚拟网络设备的 OpenStac, Docker 容器之间的连接, OVS 的连接, 都是使用 evth-pair 技术

   ![avatar](/static/image/docker/dokcer-network-ping.png)

   - 所有的容器不指定网络的情况下, 都是 docker0 路由的, docker 会给我们的容器分配一个默认的可用 ip

   ![avatar](/static/image/docker/dokcer-network-containers.png)

   - Docker 中所有网络接口都是虚拟的, 虚拟的转发效率高[内网传递文件]
   - 只要容器删除，对应的网桥一对就没了

2. ~~`–link: 本质就是在hosts配置中添加映射`~~

   - 问题: 我们编写了一个微服务, database url=ip: 项目不重启, 数据 ip 换了, 我们希望可以处理这个问题, 可以通过名字来进行访问容器?

   - demo

     ```shell
     $ docker exec -it tomcat02 ping tomca01   # ping不通
     ping: tomca01: Name or service not known

     # 运行一个tomcat03 --link tomcat02
     $ docker run -d -P --name tomcat03 --link tomcat02 tomcat
     5f9331566980a9e92bc54681caaac14e9fc993f14ad13d98534026c08c0a9aef

     # 用tomcat03 ping tomcat02 可以ping通
     $ docker exec -it tomcat03 ping tomcat02
     PING tomcat02 (172.17.0.3) 56(84) bytes of data.
     64 bytes from tomcat02 (172.17.0.3): icmp_seq=1 ttl=64 time=0.115 ms
     64 bytes from tomcat02 (172.17.0.3): icmp_seq=2 ttl=64 time=0.080 ms

     # 用tomcat02 ping tomcat03 ping不通
     ```

   - `docker network inspect 网络id 网段相同`

     ![avatar](/static/image/docker/dokcer-containers-tomcat.png)

   - `docker inspect tomcat03`

     ![avatar](/static/image/docker/dokcer-containers-tomcat03.png)

   - 查看 tomcat03 里面的 `/etc/hosts` 发现有 tomcat02 的配置

     ![avatar](/static/image/docker/dokcer-containers-tomcat03-host.png)

3. 查看所有的 docker 网络

   ```shell
   docker network ls
   # 网络模式
   # bridge: 桥接 docker[默认, 自己创建也是用bridge模式]
   # none: 不配置网络, 一般不用
   # host: 和所主机共享网络
   # container: 容器网络连通[用得少! 局限很大]

   docker network inspect bridge;
   ```

4. 在自定义的网络下, 服务可以互相 ping 通, 不用使用 –link

   ```shell
   # docker0, 特点: 默认, 域名不能访问. --link可以打通连接, 但是很麻烦!
   # 自定义一个网络: 可以通过容器名称互相 ping 通
   $ docker network create --driver bridge --subnet 192.168.0.0/16 --gateway 192.168.0.1 tomcat-net

   $ docker run -d -P --name=tomcaot-net-01 --net=tomcat-net tomcat
   $ docker run -d -P --name=tomcaot-net-01 --net=tomcat-net tomcat
   ```

5. 推荐我们平时为不同的集群使用不同的自定义网络

   - 不同的集群使用不同的网络, 保证集群是安全和健康的

6. 网络连通: 不同 network 之间通信

   - 假设要跨网络操作别人, 就需要使用 docker network connect 连通

   ```shell
   $ docker run -d -P --name tomcat01 tomcat
   $ docker run -d -P --name tomcat02 tomcat
   # 此时 tomcat01 ping 不通 tomcat-net-01
   ```

   - 要将 tomcat01 连通 tomcat—net-01, 连通就是将 tomcat01 加到 tomcat-net 网络: 一个容器两个 ip[tomcat01]

   ```shell
   docker network connect tomcat01 tomcat-net
   # 此时 tomcat01 ping 能通 tomcat-net-01
   # 此时 tomcat02 ping 不能通 tomcat-net-01
   ```

### 7. install container

1. portainer

   ```yaml
   # docker run -d --name dev-portainer  -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v /root/portainer/data:/data portainer/portainer-ce:latest
   version: '2.1'
   services:
     portainer:
       restart: always
       image: portainer/portainer
       container_name: portainer
       ports:
         - 9000:9000
       environment:
         TZ: Asia/Shanghai
       volumes:
         - /var/run/docker.sock:/var/run/docker.sock
         - /root/portainer/data:/data
   ```

2. install mysql

   ```shell
   sudo docker pull mysql:5.7

   docker run -p 3306:3306 --name mysql -v /root/mysql/conf.d:/etc/mysql/conf.d -v /root/mysql/logs:/var/log/mysql -v /root/mysql/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD='Yu***?' -d mysql:5.7
   sudo docker exec -it mysql /bin/bash
   mysql -u root -p
   GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'Yu***?' WITH GRANT OPTION;
   FLUSH  PRIVILEGES;
   docker logs --tail=200 -f mysql
   ```

3. install redis

   ```shell
   docker run -d --name redis -p 6379:6379 -v /root/redis/data:/data -v /root/redis/conf/redis.conf:/usr/local/etc/redis/redis.conf  -v /root/redis/log:/logs redis:5.0 redis-server /usr/local/etc/redis/redis.conf --appendonly yes
   ```

4. install rabbitmq

   ```shell
   docker pull rabbitmq:3.7.7-management

   docker run -d -p 5672:5672 -p 15672:15672 --name rabbitmq 3f92e6354d11

   docker run -d --name rabbitmq -p 5672:5672 -p 15672:15672 -v /root/rabbitmq/data:/var/lib/rabbitmq -v /root/rabbitmq/logs:/var/log/rabbitmq  --hostname rabbit -e RABBITMQ_DEFAULT_VHOST=/ -e RABBITMQ_DEFAULT_USER=guest -e RABBITMQ_DEFAULT_PASS=guest rabbitmq:3.7.7-management
   ```

5. install activemq

   ```shell
   docker pull webcenter/activemq
   # -v /root/activemq/lib/custom:/opt/activemq/lib/custom
   #  the jar must be in /lib
   docker run -d --name activemq -p 8161:8161 -p 61613:61613 -p 61616:61616 -v /root/activemq/conf:/opt/activemq/conf -v /root/activemq/data:/data/activemq -v /root/activemq/logs:/var/log/activemq webcenter/activemq
   ```

6. install mongodb

   #where to log
   logpath=/var/log/mongodb/mongodb.log

   ```shell
   docker run -d --name mongo -p 27017:27017 -v /root/mongo/data/db:/data/db cdc6740b66a7

   docker run -d --name mongodb -p 27017:27017 -v /root/mongodb/configdb:/data/configdb/ -v /root/mongodb/logs:/var/log/mongodb -v /root/mongodb/data/db/:/var/lib/mongodb cdc6740b66a7
   docker exec -it CONTAINER_ID /bin/bash

   use admin
   db.createUser({
       user: "admin",
       pwd: "Yu***?",
       roles: [ { role: "root", db: "admin" } ]
   });

   # test auth

   mongo --port 27017 -u admin -p Yu***? --authenticationDatabase admin
   ```

7. docker-tomcat

   ```shell
   sudo docker pull tomcat:8.5.40
   mkdir tomcat # /root
   docker run -d -p 8001:8080 --name tomcat8 -v /root/tomcat/conf/:/usr/local/tomcat/conf -v /root/tomcat/logs:/usr/local/tomcat/logs -v /root/tomcat/webapps/:/usr/local/tomcat/webapps tomcat

   sudo docker exec -it tomcat8 /bin/bash
   # look up log
   docker logs --tail=200 -f tomcat8
   ```

8. mssql-server

9. nginx

   ```shell
   # notice: upstream should be place in nginx.conf
   docker pull nginx
   # get default conf
   docker run --name nginx-test -p 80:80 -d nginx
   docker cp nginx-test:/etc/nginx/nginx.conf /root/nginx/conf/nginx.conf
   docker cp nginx-test:/etc/nginx/conf.d /root/nginx/conf/conf.d

   # delete container
   docker container stop CONTAINER_ID
   docker rm CONTAINER_ID

   # start new container
   docker run -d -p 80:80 --name nginx -v /root/nginx/www:/usr/share/nginx/html -v /root/nginx/conf/nginx.conf/nginx.conf:/etc/nginx/nginx.conf -v /root/nginx/conf/conf.d:/etc/nginx/conf.d -v /root/nginx/logs:/var/log/nginx nginx

   # set aoto start
   docker update --restart=always 镜像ID
   ```

10. zookeeper

    ```yaml
    zookepper:
      image: zookeeper:3.4.10
      restart: always
      hostname: zoo1
      container_name: dev-zookeeper01
      #domainname:
      ports:
        - 2181:2181
      volumes:
        - /root/zookeeper/zoo1/data:/data
        - /root/zookeeper/zoo1/datalog:/datalog
      environment:
        ZOO_MY_ID: 1
        ZOO_SERVERS: server.1=zoo1:2888:3888
    ```

---

### 8. docker directory structure

1. log: `/var/lib/docker/docker/CONTAINERID/CONTAINERID-json.log`
2. docker install software
   - step 1: install demo with no mounted point, and cp conf to `host machine`
   - step 2: install with mounted point and conf
3. docker will mapping directory in `/var/lib/docker/container`

   - path: `/var/lib/docker/containers/035a9c97bf291e463ce6d45a5fa9343f6f9bb989726ecfde496da5db04438a9f`
   - filename: `config.v2.json`
   - file explain: this file will explain the mounted path for this docker container
   - specify node: `MountPoints`

   ```json
   {
     "StreamConfig": {},
     "State": {
       "Running": true,
       "Paused": false,
       "Restarting": false,
       "OOMKilled": false,
       "RemovalInProgress": false,
       "Dead": false,
       "Pid": 2526,
       "ExitCode": 0,
       "Error": "",
       "StartedAt": "2019-10-03T03:58:58.51394376Z",
       "FinishedAt": "2019-10-03T03:58:29.939636928Z",
       "Health": null
     },
     "ID": "035a9c97bf291e463ce6d45a5fa9343f6f9bb989726ecfde496da5db04438a9f",
     "Created": "2019-08-31T15:32:43.041565523Z",
     "Managed": false,
     "Path": "docker-entrypoint.sh",
     "Args": ["rabbitmq-server"],
     "Config": {
       "Hostname": "rabbit",
       "Domainname": "",
       "User": "",
       "AttachStdin": false,
       "AttachStdout": false,
       "AttachStderr": false,
       "ExposedPorts": {
         "15671/tcp": {},
         "15672/tcp": {},
         "25672/tcp": {},
         "4369/tcp": {},
         "5671/tcp": {},
         "5672/tcp": {}
       },
       "Tty": false,
       "OpenStdin": false,
       "StdinOnce": false,
       "Env": [
         "RABBITMQ_DEFAULT_USER=guest",
         "RABBITMQ_DEFAULT_PASS=guest",
         "RABBITMQ_DEFAULT_VHOST=/",
         "PATH=/opt/rabbitmq/sbin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
         "OPENSSL_VERSION=1.1.1c",
         "OPENSSL_SOURCE_SHA256=f6fb3079ad15076154eda9413fed42877d668e7069d9b87396d0804fdb3f4c90",
         "OPENSSL_PGP_KEY_IDS=0x8657ABB260F056B1E5190839D9C4D26D0E604491 0x5B2545DAB21995F4088CEFAA36CEE4DEB00CFE33 0xED230BEC4D4F2518B9D7DF41F0DB4D21C1D35231 0xC1F33DD8CE1D4CC613AF14DA9195C48241FBF7DD 0x7953AC1FBC3DC8B3B292393ED5E9E43F7DF9EE8C 0xE5E52560DD91C556DDBDA5D02064C53641C25E5D",
         "OTP_VERSION=22.0.7",
         "OTP_SOURCE_SHA256=04c090b55ec4a01778e7e1a5b7fdf54012548ca72737965b7aa8c4d7878c92bc",
         "RABBITMQ_DATA_DIR=/var/lib/rabbitmq",
         "RABBITMQ_VERSION=3.7.16",
         "RABBITMQ_PGP_KEY_ID=0x0A9AF2115F4687BD29803A206B73A36E6026DFCA",
         "RABBITMQ_HOME=/opt/rabbitmq",
         "RABBITMQ_LOGS=-",
         "RABBITMQ_SASL_LOGS=-",
         "HOME=/var/lib/rabbitmq",
         "LANG=C.UTF-8",
         "LANGUAGE=C.UTF-8",
         "LC_ALL=C.UTF-8"
       ],
       "Cmd": ["rabbitmq-server"],
       "Image": "3f92e6354d11",
       "Volumes": { "/var/lib/rabbitmq": {} },
       "WorkingDir": "",
       "Entrypoint": ["docker-entrypoint.sh"],
       "OnBuild": null,
       "Labels": {}
     },
     "Image": "sha256:3f92e6354d117ecfad6ab83c62d299db863da799294f0c62f7d66269bceb9a6b",
     "NetworkSettings": {
       "Bridge": "",
       "SandboxID": "a87bc6b3b6a268ef5e688cafdec13051288adca1b4513e1b568779910bf4e604",
       "HairpinMode": false,
       "LinkLocalIPv6Address": "",
       "LinkLocalIPv6PrefixLen": 0,
       "Networks": {
         "bridge": {
           "IPAMConfig": null,
           "Links": null,
           "Aliases": null,
           "NetworkID": "7c2504e13889d053ac484fa46d9d3cbf8489de503243a7ad7e8f2e0e6d442030",
           "EndpointID": "d81a6fb5e4df99e417319849a38a8061225ea90ceda5fe7efeae629baf5aa254",
           "Gateway": "172.17.0.1",
           "IPAddress": "172.17.0.3",
           "IPPrefixLen": 16,
           "IPv6Gateway": "",
           "GlobalIPv6Address": "",
           "GlobalIPv6PrefixLen": 0,
           "MacAddress": "02:42:ac:11:00:03",
           "DriverOpts": null,
           "IPAMOperational": false
         }
       },
       "Service": null,
       "Ports": {
         "15671/tcp": null,
         "15672/tcp": [{ "HostIp": "0.0.0.0", "HostPort": "15672" }],
         "25672/tcp": null,
         "4369/tcp": null,
         "5671/tcp": null,
         "5672/tcp": [{ "HostIp": "0.0.0.0", "HostPort": "5672" }]
       },
       "SandboxKey": "/var/run/docker/netns/a87bc6b3b6a2",
       "SecondaryIPAddresses": null,
       "SecondaryIPv6Addresses": null,
       "IsAnonymousEndpoint": false,
       "HasSwarmEndpoint": false
     },
     "LogPath": "/var/lib/docker/containers/035a9c97bf291e463ce6d45a5fa9343f6f9bb989726ecfde496da5db04438a9f/035a9c97bf291e463ce6d45a5fa9343f6f9bb989726ecfde496da5db04438a9f-json.log",
     "Name": "/rabbitmq",
     "Driver": "overlay2",
     "OS": "linux",
     "MountLabel": "",
     "ProcessLabel": "",
     "RestartCount": 0,
     "HasBeenStartedBefore": true,
     "HasBeenManuallyStopped": false,
     "MountPoints": {
       "/var/lib/rabbitmq": {
         "Source": "/root/rabbitmq/data",
         "Destination": "/var/lib/rabbitmq",
         "RW": true,
         "Name": "",
         "Driver": "",
         "Type": "bind",
         "Propagation": "rprivate",
         "Spec": {
           "Type": "bind",
           "Source": "/root/rabbitmq/data",
           "Target": "/var/lib/rabbitmq"
         },
         "SkipMountpointCreation": false
       },
       "/var/log/rabbitmq": {
         "Source": "/root/rabbitmq/logs",
         "Destination": "/var/log/rabbitmq",
         "RW": true,
         "Name": "",
         "Driver": "",
         "Type": "bind",
         "Propagation": "rprivate",
         "Spec": {
           "Type": "bind",
           "Source": "/root/rabbitmq/logs",
           "Target": "/var/log/rabbitmq"
         },
         "SkipMountpointCreation": false
       }
     },
     "SecretReferences": null,
     "ConfigReferences": null,
     "AppArmorProfile": "",
     "HostnamePath": "/var/lib/docker/containers/035a9c97bf291e463ce6d45a5fa9343f6f9bb989726ecfde496da5db04438a9f/hostname",
     "HostsPath": "/var/lib/docker/containers/035a9c97bf291e463ce6d45a5fa9343f6f9bb989726ecfde496da5db04438a9f/hosts",
     "ShmPath": "",
     "ResolvConfPath": "/var/lib/docker/containers/035a9c97bf291e463ce6d45a5fa9343f6f9bb989726ecfde496da5db04438a9f/resolv.conf",
     "SeccompProfile": "",
     "NoNewPrivileges": false
   }
   ```

---

## Issue

1.  remove failed

    - error message:

    ```txt
    Error response from daemon: conflict: unable to delete 0f3e07c0138f (cannot be forced) - image has dependent child images
    ```

    - solution:
      - remove REPOSITORY name
      - then remove IMAGE_ID
