#!/bin/bash

# 结束进程
./stop.sh 8100

# 配置部分
JAR_FILE="/server/jtt808/jtt808-server.jar"
LOG_FILE="/server/jtt808/jtt808-server.log"

echo "正在启动新的 JAR 应用：$JAR_FILE"
nohup java -jar $JAR_FILE > $LOG_FILE 2>&1 &

NEW_PID=$!
if [ $? -eq 0 ]; then
    echo "应用已启动，PID: $NEW_PID，日志输出到 $LOG_FILE"
else
    echo "启动失败，请检查 JAR 文件路径或 Java 是否安装。"
    exit 1
fi