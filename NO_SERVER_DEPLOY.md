# 无服务器真实部署

结论：GitHub 不能运行 Spring Boot 和 MySQL。没有服务器时，用下面组合：

- 前端：GitHub Pages
- 后端：Render
- 数据库：Aiven MySQL

## 你现在要做

1. 打开 Aiven，创建 MySQL。
2. 打开 Render，创建 Web Service。
3. 把 Aiven 的 MySQL 信息填到 Render 环境变量。
4. 把 Render 后端地址填到 GitHub Actions 变量。
5. 重新运行 GitHub Pages 部署。

## Aiven MySQL

创建 MySQL 后记录：

```text
DB_HOST=
DB_PORT=
DB_NAME=dormitory_system
DB_USERNAME=
DB_PASSWORD=
DB_SSL_MODE=REQUIRED
```

导入 SQL 顺序：

```text
database/01_create_tables.sql
database/02_insert_data.sql
database/03_views.sql
database/04_triggers.sql
database/05_procedures.sql
```

## Render 后端

新建 Web Service：

```text
Source: Sonamlike101/-sonam0001
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

后端测试地址：

```text
https://你的render服务.onrender.com/api/health
https://你的render服务.onrender.com/api/dashboard
```

## GitHub Pages 前端

进入仓库：

```text
Settings -> Secrets and variables -> Actions -> Variables
```

新增：

```text
VITE_API_BASE_URL=https://你的render服务.onrender.com/api
```

然后运行：

```text
Actions -> Deploy Frontend to GitHub Pages -> Run workflow
```

最终访问：

```text
https://sonamlike101.github.io/-sonam0001/
```

登录：

```text
admin
123456
```
