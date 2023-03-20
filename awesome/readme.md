## intros

1. 整机: top/uptime `cpu + io + config`

   - 查看 %CPU %MEM load average: a[1min], b[5min], c[15min]
   - (a + b + c) / 3 > 60% 表示系统压力大 || `(a + b + c) / 3 > 核心数`
   - f1 可以看到每个 CPU 的线程情况

2. CPU: `vmstat -n 2 3`

   - 没 2 秒采样一次, 一共采样 3 次
   - 查看 procs [sum(r)/count < 2], cpu

   ```js
   // r: 运行和等待 CPU 时间片的进程数;
   //    原则上没核 CPU 上不要超过2个 [(1 + 0 + 0)3 < 2], 整个系统运行队列不要超过总核心数的 2 倍
   //    否则表示系统压力大
   // b: 等待资源的进程数: 如网络IO, 磁盘IO等
   // (us+sy) 应该小于 80%
   // id: 空闲 CPU 百分比
   // wa: 系统等待IO的占比
   // st: 被偷取的占比
   procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
   r  b   swpd   free   buff  cache   si   so    bi    bo   in      cs  us sy id wa st
   1  0      0 29251444 589496 1903068    0    0     0     0    0    0  0  0 100  0  0
   0  0      0 29251444 589496 1903068    0    0     0    36  627 1054  0  0 100  0  0
   0  0      0 29251444 589496 1903068    0    0     0     0  596  997  0  0 100  0  0
   ```

   - `mpstat -P ALL 2`: 查看所有 CPU 核信息 2 秒打印一次
   - `pidstat -p 2 -p PID`: 每个进程使用 cpu 的用量分解信息 2 秒一次

3. 内存: `free -m[以 MB 大小显示]`&`pidstat -u 2 -p PID`

   - free/total < 20% 表示内存不足
   - free/total > 70% 表示内存充足
   - free/total: 20 - 70 之间表示够用

4. 硬盘: `df -h`
5. 磁盘 IO

   - `iostat -xdk 2 3`: 2 秒 3 次
   - 查看 util: 值将近 100 时表示磁盘跑满, 表示要加磁盘或者优化代码
   - 查看 await[平均等待时间小好] 远高于 svctm[平均服务时间] 表示 IO 等待时间过长
   - `pidstat -d 2 -p PID`

6. 网络 IO: `ifstat -l`
