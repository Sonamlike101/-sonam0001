# 部署清单

## 1. 数据库

- 平台：Aiven MySQL
- 数据库名：`dormitory_system`
- SSL：`REQUIRED`
- SQL：按 `database` 目录编号顺序导入

## 2. 后端

- 平台：Render
- 仓库：`Sonamlike101/-sonam0001`
- 环境：Docker
- Dockerfile：`./backend/Dockerfile`
- Context：`./backend`

Render 环境变量：

```text
DB_HOST=
DB_PORT=
DB_NAME=dormitory_system
DB_USERNAME=
DB_PASSWORD=
DB_SSL_MODE=REQUIRED
```

## 3. 前端

GitHub Actions 变量：

```text
VITE_API_BASE_URL=https://你的后端地址.onrender.com/api
```

前端地址：

```text
https://sonamlike101.github.io/-sonam0001/
```
