#!/bin/bash

# 配置部分
PORT=8100
JAR_FILE="/server/jtt808/jtt808-server.jar"
LOG_FILE="/server/jtt808/jtt808-server.log"

echo "[$(date)] 检查端口 $PORT 是否被占用..."

# 查找占用端口的 PID
PID=$(lsof -t -i:$PORT)

if [ ! -z "$PID" ]; then
    echo "发现进程 PID $PID 占用了端口 $PORT，正在终止..."
    kill -9 $PID
    if [ $? -eq 0 ]; then
        echo "进程已成功终止。"
    else
        echo "无法终止进程 PID $PID"
        exit 1
    fi
else
    echo "端口 $PORT 当前未被占用。"
fi

echo "正在启动新的 jar 应用：$JAR_FILE"
nohup java -jar $JAR_FILE > $LOG_FILE 2>&1 &

NEW_PID=$!
if [ $? -eq 0 ]; then
    echo "应用已启动，PID: $NEW_PID，日志输出到 $LOG_FILE"
else
    echo "启动失败，请检查 JAR 文件路径或 Java 是否安装。"
    exit 1
fi