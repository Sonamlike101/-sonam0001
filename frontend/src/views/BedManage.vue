<template>
  <section>
    <div class="page-header">
      <h1 class="page-title">床位管理</h1>
      <el-button :icon="Refresh" @click="loadDetails">刷新床位详情</el-button>
    </div>
    <div class="content-panel bed-detail-panel">
      <el-table v-loading="detailLoading" :data="bedDetails" border stripe height="260">
        <el-table-column prop="buildingNo" label="楼栋" width="90" />
        <el-table-column prop="roomNo" label="房间" width="90" />
        <el-table-column prop="bedLabel" label="床位" width="100" />
        <el-table-column prop="bedStatus" label="床位状态" width="120">
          <template #default="{ row }">
            <el-tag :type="row.bedStatus === 'AVAILABLE' ? 'success' : 'warning'" effect="plain">{{ row.bedStatus }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="studentNo" label="学号" width="130" />
        <el-table-column prop="studentName" label="学生姓名" width="120" />
      </el-table>
    </div>
    <CrudPage :config="bedConfig" />
  </section>
</template>

<script setup>
import { onMounted, ref } from 'vue'
import { Refresh } from '@element-plus/icons-vue'
import CrudPage from '../components/CrudPage.vue'
import { bedConfig } from '../config/modules'
import request from '../utils/request'

const bedDetails = ref([])
const detailLoading = ref(false)

async function loadDetails() {
  detailLoading.value = true
  try {
    bedDetails.value = await request.get('/beds/details')
  } finally {
    detailLoading.value = false
  }
}

onMounted(loadDetails)
</script>

<style scoped>
.bed-detail-panel {
  margin-bottom: 14px;
}
</style>
