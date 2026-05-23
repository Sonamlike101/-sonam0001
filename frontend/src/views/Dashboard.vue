<template>
  <section>
    <div class="page-header">
      <h1 class="page-title">首页数据看板</h1>
      <el-button :icon="Refresh" @click="loadDashboard">刷新</el-button>
    </div>

    <div class="metric-grid">
      <div v-for="item in metrics" :key="item.label" class="metric">
        <div class="metric-label">{{ item.label }}</div>
        <div class="metric-value">{{ item.value }}</div>
      </div>
    </div>

    <div class="chart-grid">
      <div class="chart-panel">
        <h2 class="chart-title">房间入住率</h2>
        <div ref="roomChartRef" class="chart"></div>
      </div>
      <div class="chart-panel">
        <h2 class="chart-title">维修状态分布</h2>
        <div ref="repairChartRef" class="chart"></div>
      </div>
      <div class="chart-panel">
        <h2 class="chart-title">月度费用统计</h2>
        <div ref="feeChartRef" class="chart"></div>
      </div>
      <div class="chart-panel">
        <h2 class="chart-title">504宿舍概览</h2>
        <el-descriptions :column="1" border>
          <el-descriptions-item label="宿舍位置">南区11栋504</el-descriptions-item>
          <el-descriptions-item label="床位总数">4</el-descriptions-item>
          <el-descriptions-item label="当前入住">4</el-descriptions-item>
          <el-descriptions-item label="入住率">100%</el-descriptions-item>
        </el-descriptions>
      </div>
    </div>
  </section>
</template>

<script setup>
import { computed, nextTick, onMounted, onUnmounted, ref } from 'vue'
import * as echarts from 'echarts'
import { Refresh } from '@element-plus/icons-vue'
import request from '../utils/request'

const dashboard = ref({ overview: {}, roomOccupancy: [], repairStatus: [], feeMonthly: [] })
const roomChartRef = ref(null)
const repairChartRef = ref(null)
const feeChartRef = ref(null)
let roomChart
let repairChart
let feeChart

const metrics = computed(() => {
  const overview = dashboard.value.overview || {}
  return [
    { label: '学生总数', value: overview.studentCount ?? 0 },
    { label: '房间数量', value: overview.roomCount ?? 0 },
    { label: '床位总数', value: overview.bedCount ?? 0 },
    { label: '已入住床位', value: overview.occupiedBedCount ?? 0 },
    { label: '未缴清账单', value: overview.unpaidBillCount ?? 0 },
    { label: '待处理维修', value: overview.pendingRepairCount ?? 0 },
    { label: '今日来访', value: overview.todayVisitCount ?? 0 },
    { label: '系统状态', value: '正常' }
  ]
})

async function loadDashboard() {
  dashboard.value = await request.get('/dashboard')
  await nextTick()
  renderCharts()
}

function renderCharts() {
  roomChart = roomChart || echarts.init(roomChartRef.value)
  repairChart = repairChart || echarts.init(repairChartRef.value)
  feeChart = feeChart || echarts.init(feeChartRef.value)

  const rooms = dashboard.value.roomOccupancy || []
  roomChart.setOption({
    tooltip: {},
    grid: { left: 42, right: 20, top: 24, bottom: 36 },
    xAxis: { type: 'category', data: rooms.map((item) => item.roomNo) },
    yAxis: { type: 'value', max: 100 },
    series: [{ type: 'bar', data: rooms.map((item) => item.occupancyRate), itemStyle: { color: '#0f766e' } }]
  })

  const repairs = dashboard.value.repairStatus || []
  repairChart.setOption({
    tooltip: { trigger: 'item' },
    series: [
      {
        type: 'pie',
        radius: ['42%', '68%'],
        data: repairs.map((item) => ({ name: item.status, value: item.count })),
        color: ['#2563eb', '#f59e0b', '#16a34a', '#dc2626']
      }
    ]
  })

  const fees = dashboard.value.feeMonthly || []
  feeChart.setOption({
    tooltip: {},
    legend: { top: 0 },
    grid: { left: 48, right: 20, top: 42, bottom: 36 },
    xAxis: { type: 'category', data: fees.map((item) => item.typeName) },
    yAxis: { type: 'value' },
    series: [
      { name: '应缴', type: 'bar', data: fees.map((item) => item.totalAmount), itemStyle: { color: '#2563eb' } },
      { name: '已缴', type: 'bar', data: fees.map((item) => item.paidAmount), itemStyle: { color: '#16a34a' } }
    ]
  })
}

function resizeCharts() {
  roomChart?.resize()
  repairChart?.resize()
  feeChart?.resize()
}

onMounted(() => {
  loadDashboard()
  window.addEventListener('resize', resizeCharts)
})

onUnmounted(() => {
  window.removeEventListener('resize', resizeCharts)
  roomChart?.dispose()
  repairChart?.dispose()
  feeChart?.dispose()
})
</script>
