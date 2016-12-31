#!/bin/bash
declare -a filearray
declare -a dirarray

echo '<!DOCTYPE html><html><head><meta charset="utf-8"><title>孙文峰的docker实验</title>
<link rel="stylesheet" href="index.css">
<link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head><body>' > index.html

printf '<div class="text">
    实现思路:
    <ol>
        <li>基于ceotos最小安装镜像,安装nginx作为静态服务器，并通过sed命令设置服务器root为“/”</li>
        <li>将脚本COPY到docker中去，并在run时执行，若指定--path 参数，则可以指定相应的路径。否则为"/etc/"</li>
        <li>运行 `docker run -v ~/workspace/homework:/sunwenfeng --name CONTAINER_NAME -p 80:80 CONTAINER_ID [-path PATH]`</li>
        <li>若想改变路径： docker exec -d CONTAINER_ID /sunwenfeng/list.sh [-path PATH]</li>
    </ol>
</div>' >> index.html


echo '<div class="content">' >> index.html

if [ -n "$1" -a "$1" = "-path" -a -d "$2" -a -e "$2" ]; then
    for file in $(ls $2)
    do
        basepath="$2$file"
        if test -f $basepath; then
            filearray+=($file);
        fi
        if  test -d $basepath; then
            dirarray+=($file);
        fi
    done

    echo '<div class="file-title list-group-item active" data-toggle="collapse" data-target=".file"> 文件类型 <span class="badge">' >> index.html
    echo "${#filearray[*]}</span></div>" >> index.html

    echo '<div class="file">' >> index.html
    for ((i=0;i<${#filearray[*]};i++));
    do
        let re=$(( ${i} % 5 ))
        if test ${re} -eq 0 ; then
            echo '<span class="label label-default">' >> index.html
            echo ${filearray[$i]} >> index.html
            echo "</span>" >> index.html
        fi
        if test ${re} -eq 1 ; then
            echo '<span class="label label-primary">' >> index.html
            echo ${filearray[$i]} >> index.html
            echo "</span>" >> index.html
        fi
        if test ${re} -eq 2 ; then
            echo '<span class="label label-success">' >> index.html
            echo ${filearray[$i]} >> index.html
            echo "</span>" >> index.html
        fi
        if test ${re} -eq 3 ; then
            echo '<span class="label label-info">' >> index.html
            echo ${filearray[$i]} >> index.html
            echo "</span>" >> index.html
        fi
        if test ${re} -eq 4 ; then
            echo '<span class="label label-warning">' >> index.html
            echo ${filearray[$i]} >> index.html
            echo "</span>" >> index.html
        fi
    done
    echo "</div>" >> index.html

    echo '<div class="dir-title list-group-item active" data-toggle="collapse" data-target=".dir"> 目录类型 <span class="badge">' >> index.html
    echo "${#dirarray[*]}</span></div>" >> index.html
    echo '<div class="dir collapse in">' >> index.html
    for file in ${dirarray[*]};
    do
        echo '<div class="list-group-item">' >> index.html
        echo $file >> index.html
        echo "</div>" >> index.html
    done
    echo "</div>" >> index.html
else
    echo "路径错误！"
    echo '<div class="alert alert-danger">路径错误！</div>' >> index.html
fi
echo '</div>' >> index.html
echo "</body></html>" >> index.html
#运行nginx
pkill -9 nginx
/usr/local/nginx/sbin/nginx
echo "nginx启动成功"
# 挂起docker
tail -f welcome
