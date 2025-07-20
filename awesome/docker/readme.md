## docker:

1. layer 的文件系统： kernel 内核
2. 优点: 打包快速 + 打包环境 + 启动快 + 方便部署与交付[ci/cd] + 高效资源利用
3. image, container, -v, -p, exec, cp, run, --link, inspect,
4. docker0: veth-pair, 成对出现【docker0+app】只能使用 IP ping 通

## dockerfile

1. from
2. add:
3. copy:
4. run
5. workdir
6. volume
7. env[-e ]/arg[--build-arg]
8. cmd
9. entrypoint: **`不能重写最后的命令, 且不能识别env & arg 变量`**
