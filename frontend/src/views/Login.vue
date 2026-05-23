<template>
  <div class="login-page">
    <div class="login-panel">
      <div class="login-copy">
        <h1>11栋南区504宿舍管理系统</h1>
        <p>学生、床位、费用、维修、值日和来访数据统一管理</p>
      </div>
      <el-form class="login-form" :model="form" @submit.prevent>
        <h2>系统登录</h2>
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
    linear-gradient(135deg, rgba(15, 118, 110, 0.86), rgba(23, 32, 51, 0.9)),
    url("https://images.unsplash.com/photo-1518005020951-eccb494ad742?auto=format&fit=crop&w=1600&q=80") center/cover;
}

.login-panel {
  display: grid;
  grid-template-columns: minmax(280px, 1fr) 380px;
  width: min(920px, 100%);
  min-height: 430px;
  overflow: hidden;
  border-radius: 8px;
  background: #ffffff;
  box-shadow: 0 18px 55px rgba(15, 23, 42, 0.22);
}

.login-copy {
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
  padding: 42px;
  color: #ffffff;
  background: linear-gradient(135deg, #172033, #0f766e);
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

.login-form {
  align-self: center;
  padding: 42px;
}

.login-form h2 {
  margin: 0 0 22px;
  font-size: 22px;
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
