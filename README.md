# 11栋南区504宿舍管理系统

数据库课程设计项目，包含 MySQL 数据库脚本、Spring Boot + MyBatis-Plus 后端、Vue3 + Element Plus + ECharts 前端。

## 项目结构

```text
database/   MySQL 8.0 数据库脚本
backend/    Spring Boot 后端项目
frontend/   Vue3 前端项目
```

## 数据库

按顺序执行：

```bat
"D:\Software\MySQL\mysql-8.0\bin\mysql.exe" -u root -p < database\01_create_tables.sql
"D:\Software\MySQL\mysql-8.0\bin\mysql.exe" -u root -p < database\02_insert_data.sql
"D:\Software\MySQL\mysql-8.0\bin\mysql.exe" -u root -p < database\03_views.sql
"D:\Software\MySQL\mysql-8.0\bin\mysql.exe" -u root -p < database\04_triggers.sql
"D:\Software\MySQL\mysql-8.0\bin\mysql.exe" -u root -p < database\05_procedures.sql
```

## 后端启动

设置数据库密码环境变量后启动：

```bat
cd backend
set DB_PASSWORD=你的MySQL密码
"D:\progarms to D\IntelliJ IDEA Community Edition 2025.2.4\plugins\maven\lib\maven3\bin\mvn.cmd" -q -DskipTests package
java -jar target\dormitory-backend-1.0.0.jar
```

后端地址：

```text
http://127.0.0.1:8080
```

## 前端启动

```bat
cd frontend
npm install
npm run dev
```

前端地址：

```text
http://127.0.0.1:5173
```

