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
        background-color="transparent"
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
      <div class="aside-footer">
        <div class="aside-footer-label">数据库课程设计</div>
        <div class="aside-footer-value">MySQL 8.0 / Spring Boot / Vue3</div>
      </div>
    </el-aside>
    <el-container>
      <el-header class="admin-header">
        <div>
          <div class="header-title">{{ $route.meta.title || '宿舍管理系统' }}</div>
          <div class="header-subtitle">围绕南区11栋504宿舍的业务数据管理</div>
        </div>
        <div class="header-actions">
          <el-tag type="success" effect="light">MySQL 实时数据</el-tag>
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
  position: relative;
  display: flex;
  flex-direction: column;
  background: linear-gradient(180deg, #172033 0%, #101827 100%);
  border-right: 1px solid #111827;
  box-shadow: 10px 0 30px rgba(15, 23, 42, 0.08);
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
  background: linear-gradient(135deg, #0f766e, #2563eb);
  box-shadow: 0 10px 24px rgba(15, 118, 110, 0.32);
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

.aside-footer {
  margin: auto 14px 14px;
  padding: 12px;
  border: 1px solid rgba(148, 163, 184, 0.2);
  border-radius: 8px;
  background: rgba(255, 255, 255, 0.04);
}

.aside-footer-label {
  font-size: 12px;
  color: #94a3b8;
}

.aside-footer-value {
  margin-top: 5px;
  font-size: 13px;
  line-height: 1.45;
  color: #e2e8f0;
}

.admin-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 68px;
  padding: 0 22px;
  background: rgba(255, 255, 255, 0.92);
  border-bottom: 1px solid #e7edf5;
  backdrop-filter: blur(10px);
}

.header-title {
  font-size: 18px;
  font-weight: 750;
  color: #172033;
}

.header-subtitle {
  margin-top: 4px;
  font-size: 12px;
  color: #667085;
}

.header-actions {
  display: flex;
  align-items: center;
  gap: 10px;
}

.admin-main {
  padding: 20px;
  background: transparent;
}

:deep(.el-menu) {
  border-right: 0;
  padding: 12px;
}

:deep(.el-menu-item) {
  height: 44px;
  margin-bottom: 6px;
  border-radius: 8px;
  font-weight: 650;
}

:deep(.el-menu-item:hover) {
  background: rgba(255, 255, 255, 0.08);
}

:deep(.el-menu-item.is-active) {
  background: linear-gradient(135deg, #0f766e, #2563eb);
  box-shadow: 0 10px 24px rgba(15, 118, 110, 0.22);
}
</style>
