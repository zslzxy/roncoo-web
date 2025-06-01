# Roncoo Education Web - Docker 部署指南

## 项目概述

这是一个基于 Nuxt.js 3 的在线教育平台前端项目，已成功使用 Docker 进行容器化部署。

## 部署状态

✅ **成功部署** - 应用已在容器中正常运行并可访问

- **容器状态**: 运行中
- **访问地址**: http://localhost:12000
- **后端API**: https://teach.cqbaizhi.com
- **部署模式**: 开发模式（避免生产构建的SSR问题）

## 快速部署

### 方法1: 使用 Docker Compose（推荐）

```bash
# 启动服务
docker-compose up -d

# 查看日志
docker-compose logs -f

# 停止服务
docker-compose down
```

### 方法2: 使用 Docker 命令

```bash
# 构建镜像
docker build -f Dockerfile.final -t roncoo-web:latest .

# 运行容器
docker run -d \
  --name roncoo-web-app \
  -p 12000:3000 \
  -e VITE_BASE_URL=https://teach.cqbaizhi.com \
  roncoo-web:latest

# 查看容器状态
docker ps

# 查看日志
docker logs roncoo-web-app
```

## 访问应用

部署成功后，可以通过以下方式访问：

- **主页**: http://localhost:12000
- **登录页**: http://localhost:12000/login
- **注册页**: http://localhost:12000/register

## 功能验证

✅ **已验证功能**:
- 主页轮播图显示（使用占位图片）
- 课程列表展示（热门课程、新课上线）
- 用户登录/注册页面
- 导航栏和搜索功能
- 页面路由跳转
- 响应式布局

## 技术架构

- **前端框架**: Nuxt.js 3.12.4
- **Vue版本**: Vue 3.5.16
- **UI组件**: Element Plus
- **HTTP客户端**: Axios
- **容器**: Node.js 18-alpine
- **运行模式**: 开发模式（解决SSR问题）

## 环境配置

### 环境变量

- `NODE_ENV=development` - 运行环境
- `VITE_BASE_URL=https://teach.cqbaizhi.com` - 后端API地址
- `HOST=0.0.0.0` - 监听地址
- `PORT=3000` - 容器内端口

### 端口映射

- 容器内端口: 3000
- 主机端口: 12000

## 故障排除

### 常见问题

1. **容器启动失败**
   ```bash
   # 检查容器日志
   docker logs roncoo-web-app
   
   # 检查端口占用
   netstat -tulpn | grep 12000
   ```

2. **页面无法访问**
   ```bash
   # 检查容器状态
   docker ps
   
   # 测试容器内服务
   docker exec roncoo-web-app curl http://localhost:3000
   ```

3. **API请求失败**
   - 检查后端API地址是否正确
   - 确认网络连接正常
   - 查看浏览器控制台错误信息

### 重新部署

```bash
# 停止并删除现有容器
docker stop roncoo-web-app
docker rm roncoo-web-app

# 重新构建和运行
docker build -f Dockerfile.final -t roncoo-web:latest .
docker run -d --name roncoo-web-app -p 12000:3000 roncoo-web:latest
```

## 性能优化

### 生产环境建议

1. **使用多阶段构建**减少镜像大小
2. **配置健康检查**确保服务可用性
3. **设置资源限制**控制容器资源使用
4. **使用反向代理**（如Nginx）处理静态资源

### 监控和日志

```bash
# 实时查看日志
docker logs -f roncoo-web-app

# 查看容器资源使用
docker stats roncoo-web-app

# 进入容器调试
docker exec -it roncoo-web-app sh
```

## 版本历史

- **v1.0** - 初始Docker化部署
- **v2.0** - 修复SSR问题，使用开发模式
- **v3.0** - 集成真实后端API
- **v4.0** - 添加Docker Compose支持

## 联系信息

如有问题，请检查：
1. Docker服务是否正常运行
2. 端口12000是否被占用
3. 网络连接是否正常
4. 容器日志中的错误信息