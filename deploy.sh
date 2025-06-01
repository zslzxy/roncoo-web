#!/bin/bash

# Roncoo Education Web - 自动部署脚本

set -e

echo "🚀 开始部署 Roncoo Education Web..."

# 配置变量
CONTAINER_NAME="roncoo-web-app"
IMAGE_NAME="roncoo-web:latest"
PORT="12000"
DOCKERFILE="Dockerfile.final"

# 检查Docker是否运行
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker 未运行，请先启动 Docker 服务"
    exit 1
fi

# 停止并删除现有容器（如果存在）
if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "🛑 停止现有容器..."
    docker stop ${CONTAINER_NAME} || true
    docker rm ${CONTAINER_NAME} || true
fi

# 构建新镜像
echo "🔨 构建 Docker 镜像..."
docker build -f ${DOCKERFILE} -t ${IMAGE_NAME} .

# 运行新容器
echo "🏃 启动新容器..."
docker run -d \
    --name ${CONTAINER_NAME} \
    -p ${PORT}:3000 \
    -e NODE_ENV=development \
    -e VITE_BASE_URL=https://teach.cqbaizhi.com \
    -e HOST=0.0.0.0 \
    -e PORT=3000 \
    --restart unless-stopped \
    ${IMAGE_NAME}

# 等待容器启动
echo "⏳ 等待容器启动..."
sleep 10

# 检查容器状态
if docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "✅ 容器启动成功！"
    echo "📱 应用访问地址: http://localhost:${PORT}"
    echo "🔍 查看日志: docker logs -f ${CONTAINER_NAME}"
    echo "📊 容器状态: docker ps"
    
    # 测试应用是否响应
    echo "🧪 测试应用响应..."
    if curl -f -s http://localhost:${PORT} > /dev/null; then
        echo "✅ 应用响应正常！"
    else
        echo "⚠️  应用可能还在启动中，请稍后访问"
    fi
else
    echo "❌ 容器启动失败！"
    echo "📋 查看错误日志: docker logs ${CONTAINER_NAME}"
    exit 1
fi

echo "🎉 部署完成！"