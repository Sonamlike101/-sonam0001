# 后端接口测试说明

后端服务地址：

```text
http://127.0.0.1:8080
```

## 启动方式

在 `backend` 目录执行：

```bat
"D:\progarms to D\IntelliJ IDEA Community Edition 2025.2.4\plugins\maven\lib\maven3\bin\mvn.cmd" -q -DskipTests package
java -jar target\dormitory-backend-1.0.0.jar
```

## 通用 CRUD 规则

大部分模块都支持以下 RESTful 接口：

```text
GET    /api/{module}?page=1&size=10
GET    /api/{module}/list
GET    /api/{module}/{id}
POST   /api/{module}
PUT    /api/{module}/{id}
DELETE /api/{module}/{id}
```

统一返回格式：

```json
{
  "code": 200,
  "message": "success",
  "data": {}
}
```

## 模块接口

### 学生管理

```text
GET    /api/students?page=1&size=10
GET    /api/students/list
GET    /api/students/{id}
GET    /api/students/search?keyword=张明&page=1&size=10
POST   /api/students
PUT    /api/students/{id}
DELETE /api/students/{id}
```

### 楼栋、房间、床位

```text
GET    /api/buildings
GET    /api/rooms
GET    /api/beds
GET    /api/beds/details
GET    /api/check-ins
POST   /api/check-ins
PUT    /api/check-ins/{id}
DELETE /api/check-ins/{id}
```

### 卫生值日

```text
GET    /api/duties/schedules
POST   /api/duties/schedules
PUT    /api/duties/schedules/{id}
DELETE /api/duties/schedules/{id}

GET    /api/duties/records
POST   /api/duties/records
PUT    /api/duties/records/{id}
DELETE /api/duties/records/{id}
```

### 费用管理

```text
GET    /api/fees/types
GET    /api/fees/bills
GET    /api/fees/payments
POST   /api/fees/payments
```

### 维修报修

```text
GET    /api/repairs/orders
POST   /api/repairs/orders
PUT    /api/repairs/orders/{id}
DELETE /api/repairs/orders/{id}

GET    /api/repairs/processes
POST   /api/repairs/processes
```

### 宿舍物品

```text
GET    /api/items
POST   /api/items
PUT    /api/items/{id}
DELETE /api/items/{id}

GET    /api/items/borrows
POST   /api/items/borrows
```

### 来访登记

```text
GET    /api/visitors
POST   /api/visitors
PUT    /api/visitors/{id}
DELETE /api/visitors/{id}

GET    /api/visits
POST   /api/visits
PUT    /api/visits/{id}
DELETE /api/visits/{id}
```

### 首页统计

```text
GET /api/dashboard
```

返回内容包含：

```text
overview        基础数量统计
repairStatus    维修状态分布
feeMonthly      月度费用统计
roomOccupancy   房间入住率统计
```

### 操作日志

```text
GET    /api/logs
GET    /api/logs/list
GET    /api/logs/{id}
POST   /api/logs
PUT    /api/logs/{id}
DELETE /api/logs/{id}
```

## curl 测试示例

```bat
curl "http://127.0.0.1:8080/api/students?page=1^&size=5"
curl "http://127.0.0.1:8080/api/beds/details"
curl "http://127.0.0.1:8080/api/dashboard"
```

Windows `cmd` 中 URL 的 `&` 需要写成 `^&`，否则会被当成命令连接符。
