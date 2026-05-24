# 没有服务器时的真实部署方案

GitHub 不能长期运行 Spring Boot 和 MySQL。没有自己的服务器时，可以使用云托管平台：

- 前端：GitHub Pages
- 后端：Render Web Service
- 数据库：Aiven for MySQL

## 1. 创建云 MySQL

在 Aiven 创建 MySQL 服务，记录这些连接信息：

```text
Host
Port
Database
User
Password
SSL mode: REQUIRED
```

Aiven 的 Java JDBC 示例使用 `sslmode=require`，本项目已支持通过 `DB_SSL_MODE=REQUIRED` 连接云 MySQL。

## 2. 导入数据库 SQL

连接 Aiven MySQL 后，按顺序执行：

```text
database/01_create_tables.sql
database/02_insert_data.sql
database/03_views.sql
database/04_triggers.sql
database/05_procedures.sql
```

## 3. 部署后端到 Render

在 Render 新建 Web Service：

```text
Source: GitHub 仓库 Sonamlike101/-sonam0001
Environment: Docker
Dockerfile Path: ./backend/Dockerfile
Docker Context: ./backend
```

环境变量：

```text
DB_HOST=你的Aiven Host
DB_PORT=你的Aiven Port
DB_NAME=dormitory_system
DB_USERNAME=你的Aiven User
DB_PASSWORD=你的Aiven Password
DB_SSL_MODE=REQUIRED
```

部署完成后测试：

```text
https://你的render服务.onrender.com/api/health
https://你的render服务.onrender.com/api/dashboard
```

## 4. 让 GitHub Pages 前端连接后端

在 GitHub 仓库设置：

```text
Settings -> Secrets and variables -> Actions -> Variables
```

新增变量：

```text
VITE_API_BASE_URL=https://你的render服务.onrender.com/api
```

然后重新运行 GitHub Actions 的 `Deploy Frontend to GitHub Pages`。

## 5. 访问系统

```text
https://sonamlike101.github.io/-sonam0001/
```

登录：

```text
admin
123456
```
