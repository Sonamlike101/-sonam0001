<template>
  <el-container class="admin-shell">
    <el-aside class="admin-aside" width="236px">
      <div class="brand">
        <div class="brand-mark">504</div>
        <div>
          <div class="brand-name">宿舍管理系统</div>
          <div class="brand-subtitle">南区11栋</div>
        </div>
      </div>
      <el-menu
        router
        :default-active="$route.path"
        background-color="#172033"
        text-color="#cbd5e1"
        active-text-color="#ffffff"
      >
        <el-menu-item index="/dashboard">
          <el-icon><DataAnalysis /></el-icon>
          <span>首页数据看板</span>
        </el-menu-item>
        <el-menu-item index="/students">
          <el-icon><User /></el-icon>
          <span>学生信息管理</span>
        </el-menu-item>
        <el-menu-item index="/beds">
          <el-icon><House /></el-icon>
          <span>床位管理</span>
        </el-menu-item>
        <el-menu-item index="/duties">
          <el-icon><Calendar /></el-icon>
          <span>卫生值日管理</span>
        </el-menu-item>
        <el-menu-item index="/fees">
          <el-icon><Wallet /></el-icon>
          <span>费用管理</span>
        </el-menu-item>
        <el-menu-item index="/repairs">
          <el-icon><Tools /></el-icon>
          <span>维修报修管理</span>
        </el-menu-item>
        <el-menu-item index="/items">
          <el-icon><Box /></el-icon>
          <span>宿舍物品管理</span>
        </el-menu-item>
        <el-menu-item index="/visits">
          <el-icon><Location /></el-icon>
          <span>来访登记管理</span>
        </el-menu-item>
        <el-menu-item index="/logs">
          <el-icon><Document /></el-icon>
          <span>操作日志管理</span>
        </el-menu-item>
      </el-menu>
    </el-aside>
    <el-container>
      <el-header class="admin-header">
        <div class="header-title">{{ $route.meta.title || '宿舍管理系统' }}</div>
        <div class="header-actions">
          <el-tag type="success" effect="plain">MySQL 实时数据</el-tag>
          <el-button :icon="SwitchButton" @click="logout">退出</el-button>
        </div>
      </el-header>
      <el-main class="admin-main">
        <router-view />
      </el-main>
    </el-container>
  </el-container>
</template>

<script setup>
import { SwitchButton } from '@element-plus/icons-vue'
import { useRouter } from 'vue-router'

const router = useRouter()

function logout() {
  localStorage.removeItem('dormitoryLogin')
  router.push('/login')
}
</script>

<style scoped>
.admin-shell {
  min-height: 100vh;
}

.admin-aside {
  background: #172033;
  border-right: 1px solid #111827;
}

.brand {
  display: flex;
  align-items: center;
  gap: 12px;
  height: 64px;
  padding: 0 18px;
  color: #ffffff;
  border-bottom: 1px solid rgba(255, 255, 255, 0.08);
}

.brand-mark {
  display: grid;
  place-items: center;
  width: 38px;
  height: 38px;
  border-radius: 8px;
  background: #0f766e;
  font-weight: 800;
}

.brand-name {
  font-size: 16px;
  font-weight: 700;
}

.brand-subtitle {
  margin-top: 3px;
  font-size: 12px;
  color: #94a3b8;
}

.admin-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 64px;
  padding: 0 22px;
  background: #ffffff;
  border-bottom: 1px solid #e5e7eb;
}

.header-title {
  font-size: 18px;
  font-weight: 650;
}

.header-actions {
  display: flex;
  align-items: center;
  gap: 10px;
}

.admin-main {
  padding: 18px;
  background: #f4f6f8;
}

:deep(.el-menu) {
  border-right: 0;
}

:deep(.el-menu-item.is-active) {
  background: #0f766e;
}
</style>
