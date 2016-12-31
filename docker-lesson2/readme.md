## Patsnap 公司内部Docker技术培训作业
### 题目:
    使用docker-compose编排一个node应用
### 功能
    1. 显示一张静态图片
    2. 使用redis保存网站访问计数器
    3. 显示计数器和主机名
### 技术要求
    1. nodeapp使用supervisor管理进程（nginx, node）
    2. 使用docker-compose的v1和v2配置都可以
### 加分项
    1. Redis使用aof实现数据持久化
    2. 使用dockercloud/haproxy实现scale以及负载均衡
    3. 使用haproxy实现负载均衡时，实现前端网络(haproxy和nodeapp)和后端网络(nodeapp和redis)分离
    4. 把环境变量写到env_file中
    5. 使用.dockerignore文件忽略node_modules
### 思路
    1. 分别依据要求写出node和redis的dockerfile，然后build出相应的镜像
    2. 使用docker-compose 分别配置为node和redis的服务
    3. 配置自定义的bridge网络，并将服务配置为backend和frontend网络，依据不同的网络实现应用的网络隔离，并加入HA，实现auto scale和负载均衡。
