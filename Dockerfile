# 使用官方Node.js 18镜像
FROM node:18-alpine

# 设置工作目录
WORKDIR /app

# 复制package.json和package-lock.json（如果存在）
COPY package*.json ./

# 安装所有依赖（包括devDependencies，因为构建需要）
RUN npm install --silent

# 复制项目文件
COPY . .

# 设置构建时环境变量
ENV NODE_ENV=production
ENV VITE_BASE_URL=http://localhost:7700
ENV VITE_DROP_CONSOLE=true
ENV VITE_DROP_DEBUGGER=true

# 构建项目
RUN npm run build

# 设置运行时环境变量
ENV NITRO_HOST=0.0.0.0
ENV NITRO_PORT=3000

# 清理devDependencies以减小镜像大小
RUN npm prune --production && npm cache clean --force

# 暴露端口
EXPOSE 3000

# 启动应用
CMD ["node", ".output/server/index.mjs"]
