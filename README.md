
# mysqlのテスト用

    docker run -d -p 22 -v /tmp:/tmp mysql /usr/bin/supervisord

# 他のXサーバに飛ばす

    ssh 192.168.0.1 -lroot
    export DISPLAY=192.168.0.2:0
    mysql-workbench
