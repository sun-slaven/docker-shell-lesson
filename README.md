## 基于centos 7 最小安装版镜像
- 运行
```
docker run -v ~/workspace/homework:/sunwenfeng --name CONTAINER_NAME -p 80:80 CONTAINER_ID [-path PATH]
```
- 修改显示路径
```
docker run -v ~/workspace/homework:/sunwenfeng --name CONTAINER_NAME -p 80:80 CONTAINER_ID [-path PATH]
```
- 访问
```
127.0.0.1:80/sunwenfeng
```

### 实现思路
- 基于DockerFile文件创建image， 该文件中首先安装了nginx作为静态服务器，利用sed命令改变nginx.conf文件的"/"的root 指向 "/" ，然后url访问"/sunwenfeng"时可以访问相应的目录。

- 然后分别COPY所需要的脚本文件以及css文件等，利用ENTRYPOINT以及CMD命令搭配实现指定目录（默认"/etc/"）

- 最后EXPOSE 80 端口

- 在执行run命令时，指定 -p 和 -v（添加volume映射）以及 --name

- 在容器启动后可以利用 exec 命令重新执行 list.sh 并指定一个新的path，刷新浏览器可以看到最新的路径的文件情况（若path不存在或错误，则会在页面中显示出提示错误）

- list.sh动态生成了一个index.html，并依据文件类型分为文件数组和目录数组，遍历数组时依据下标采用不同的css样式。

- 页面采用bootstrap作了简单的优化，利用label和collapse 组件
