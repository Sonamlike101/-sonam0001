<template>
  <div class="login-page">
    <div class="login-panel">
      <div class="login-copy">
        <div class="login-badge">Database Course Design</div>
        <h1>11栋南区504宿舍管理系统</h1>
        <p>学生、床位、费用、维修、值日和来访数据统一管理</p>
        <div class="login-stats">
          <span>20张表</span>
          <span>REST API</span>
          <span>ECharts</span>
        </div>
      </div>
      <el-form class="login-form" :model="form" @submit.prevent>
        <h2>系统登录</h2>
        <p class="login-hint">进入后台查看南区11栋504宿舍实时数据</p>
        <el-form-item>
          <el-input v-model="form.username" size="large" placeholder="账号" :prefix-icon="User" />
        </el-form-item>
        <el-form-item>
          <el-input v-model="form.password" size="large" placeholder="密码" show-password :prefix-icon="Lock" />
        </el-form-item>
        <el-button type="primary" size="large" class="login-button" @click="login">登录</el-button>
      </el-form>
    </div>
  </div>
</template>

<script setup>
import { reactive } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { Lock, User } from '@element-plus/icons-vue'

const router = useRouter()
const form = reactive({ username: 'admin', password: '123456' })

function login() {
  if (!form.username || !form.password) {
    ElMessage.warning('请输入账号和密码')
    return
  }
  localStorage.setItem('dormitoryLogin', '1')
  router.push('/dashboard')
}
</script>

<style scoped>
.login-page {
  display: grid;
  min-height: 100vh;
  place-items: center;
  padding: 24px;
  background:
    linear-gradient(135deg, rgba(15, 118, 110, 0.88), rgba(23, 32, 51, 0.92)),
    url("https://images.unsplash.com/photo-1555854877-bab0e564b8d5?auto=format&fit=crop&w=1600&q=80") center/cover;
}

.login-panel {
  display: grid;
  grid-template-columns: minmax(280px, 1fr) 380px;
  width: min(920px, 100%);
  min-height: 430px;
  overflow: hidden;
  border-radius: 8px;
  background: #ffffff;
  box-shadow: 0 24px 70px rgba(15, 23, 42, 0.26);
}

.login-copy {
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
  padding: 42px;
  color: #ffffff;
  background:
    linear-gradient(135deg, rgba(23, 32, 51, 0.94), rgba(15, 118, 110, 0.88)),
    url("https://images.unsplash.com/photo-1518005020951-eccb494ad742?auto=format&fit=crop&w=900&q=80") center/cover;
}

.login-badge {
  align-self: flex-start;
  margin-bottom: auto;
  padding: 7px 10px;
  border: 1px solid rgba(255, 255, 255, 0.28);
  border-radius: 999px;
  background: rgba(255, 255, 255, 0.12);
  font-size: 12px;
}

.login-copy h1 {
  max-width: 460px;
  margin: 0;
  font-size: 34px;
  line-height: 1.25;
}

.login-copy p {
  margin: 14px 0 0;
  color: #dbeafe;
}

.login-stats {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  margin-top: 22px;
}

.login-stats span {
  padding: 7px 10px;
  border-radius: 8px;
  color: #e2e8f0;
  background: rgba(255, 255, 255, 0.12);
  font-size: 12px;
}

.login-form {
  align-self: center;
  padding: 42px;
}

.login-form h2 {
  margin: 0;
  font-size: 22px;
}

.login-hint {
  margin: 8px 0 22px;
  font-size: 13px;
  color: #667085;
}

.login-button {
  width: 100%;
}

@media (max-width: 820px) {
  .login-panel {
    grid-template-columns: 1fr;
  }

  .login-copy {
    min-height: 220px;
  }
}
</style>
