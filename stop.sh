#!/bin/bash

# 检查是否提供了命令行参数
if [ -z "$1" ]; then
    PORT=8100
else
    PORT=$1
fi

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