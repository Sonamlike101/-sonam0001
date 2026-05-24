# 真实部署说明

GitHub Pages 只能部署 Vue 静态前端，不能运行 Spring Boot 和 MySQL。真实部署需要一台服务器或云平台运行后端和数据库。

## 推荐方式：Docker Compose 部署到服务器

服务器要求：

- 已安装 Docker 和 Docker Compose
- 服务器开放 `80` 端口
- 如果需要直接访问后端，开放 `8080` 端口

部署命令：

```bash
git clone https://github.com/Sonamlike101/-sonam0001.git
cd -sonam0001
cp .env.prod.example .env
vim .env
docker compose -f docker-compose.prod.yml --env-file .env up -d --build
```

访问地址：

```text
http://服务器IP/
http://服务器IP/api/health
http://服务器IP/api/dashboard
```

## GitHub Pages + 远程后端

如果前端继续部署在 GitHub Pages，必须先部署后端，然后在 GitHub 仓库变量中设置：

```text
VITE_API_BASE_URL=http://后端公网地址:8080/api
```

再重新运行 GitHub Actions 发布前端。

## 数据库初始化

Docker Compose 首次启动 MySQL 时，会自动执行 `database` 目录中的 SQL 文件，创建 `dormitory_system` 数据库、表、视图、触发器、存储过程和测试数据。

如果已经启动过 MySQL 容器，初始化脚本不会重复执行。需要重新初始化时执行：

```bash
docker compose -f docker-compose.prod.yml down -v
docker compose -f docker-compose.prod.yml --env-file .env up -d --build
```
