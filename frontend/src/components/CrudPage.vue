<template>
  <section>
    <div class="page-header">
      <div>
        <h1 class="page-title">{{ config.title }}</h1>
        <p class="page-subtitle">共 {{ rows.length }} 条记录，当前筛选 {{ filteredRows.length }} 条</p>
      </div>
      <el-button type="primary" :icon="Plus" @click="openCreate">新增记录</el-button>
    </div>

    <div class="content-panel">
      <div class="toolbar">
        <div class="toolbar-left">
          <el-input
            v-model="keyword"
            clearable
            style="width: 280px"
            placeholder="输入关键词查询"
            :prefix-icon="Search"
            @keyup.enter="applyFilter"
            @clear="applyFilter"
          />
          <el-button :icon="Search" @click="applyFilter">查询</el-button>
          <el-button :icon="Refresh" @click="loadData">刷新</el-button>
        </div>
        <div class="toolbar-right">
          <el-tag effect="plain">数据库实时读取</el-tag>
        </div>
      </div>

      <el-table v-loading="loading" :data="pagedRows" stripe height="560" class="crud-table">
        <el-table-column
          v-for="column in config.columns"
          :key="column.prop"
          :prop="column.prop"
          :label="column.label"
          :width="column.width"
          show-overflow-tooltip
        >
          <template #default="{ row }">
            <el-tag v-if="column.tag" :type="tagType(row[column.prop])" effect="plain">
              {{ row[column.prop] ?? '-' }}
            </el-tag>
            <span v-else>{{ row[column.prop] ?? '-' }}</span>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="160" fixed="right">
          <template #default="{ row }">
            <div class="row-actions">
              <el-button size="small" :icon="Edit" @click="openEdit(row)">修改</el-button>
              <el-button size="small" type="danger" :icon="Delete" @click="remove(row)">删除</el-button>
            </div>
          </template>
        </el-table-column>
      </el-table>

      <div class="pagination-row">
        <el-pagination
          v-model:current-page="page"
          v-model:page-size="pageSize"
          background
          layout="total, sizes, prev, pager, next"
          :total="filteredRows.length"
          :page-sizes="[10, 20, 50]"
        />
      </div>
    </div>

    <el-dialog v-model="dialogVisible" :title="dialogTitle" width="620px" destroy-on-close>
      <el-form :model="form" label-width="110px">
        <el-form-item v-for="field in config.formFields" :key="field.prop" :label="field.label">
          <el-select v-if="field.type === 'select'" v-model="form[field.prop]" clearable style="width: 100%">
            <el-option v-for="option in field.options" :key="option.value" :label="option.label" :value="option.value" />
          </el-select>
          <el-date-picker
            v-else-if="field.type === 'date'"
            v-model="form[field.prop]"
            value-format="YYYY-MM-DD"
            type="date"
            style="width: 100%"
          />
          <el-date-picker
            v-else-if="field.type === 'datetime'"
            v-model="form[field.prop]"
            value-format="YYYY-MM-DDTHH:mm:ss"
            type="datetime"
            style="width: 100%"
          />
          <el-input-number
            v-else-if="field.type === 'number'"
            v-model="form[field.prop]"
            :precision="field.precision ?? 0"
            :step="field.step ?? 1"
            style="width: 100%"
          />
          <el-input
            v-else-if="field.type === 'textarea'"
            v-model="form[field.prop]"
            type="textarea"
            :rows="3"
          />
          <el-input v-else v-model="form[field.prop]" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submit">保存</el-button>
      </template>
    </el-dialog>
  </section>
</template>

<script setup>
import { computed, onMounted, reactive, ref } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Delete, Edit, Plus, Refresh, Search } from '@element-plus/icons-vue'
import request from '../utils/request'

const props = defineProps({
  config: {
    type: Object,
    required: true
  }
})

const rows = ref([])
const keyword = ref('')
const activeKeyword = ref('')
const loading = ref(false)
const dialogVisible = ref(false)
const editingId = ref(null)
const page = ref(1)
const pageSize = ref(10)
const form = reactive({})

const dialogTitle = computed(() => (editingId.value ? `修改${props.config.title}` : `新增${props.config.title}`))

const filteredRows = computed(() => {
  const value = activeKeyword.value.trim().toLowerCase()
  if (!value) return rows.value
  const fields = props.config.searchFields || props.config.columns.map((item) => item.prop)
  return rows.value.filter((row) => fields.some((field) => String(row[field] ?? '').toLowerCase().includes(value)))
})

const pagedRows = computed(() => {
  const start = (page.value - 1) * pageSize.value
  return filteredRows.value.slice(start, start + pageSize.value)
})

function tagType(value) {
  const map = {
    LIVING: 'success',
    AVAILABLE: 'success',
    PAID: 'success',
    FINISHED: 'success',
    LEFT: 'success',
    NORMAL: 'success',
    SUCCESS: 'success',
    PENDING: 'warning',
    PARTIAL: 'warning',
    PROCESSING: 'warning',
    BORROWING: 'warning',
    SUBMITTED: 'info',
    ACCEPTED: 'info',
    UNPAID: 'danger',
    OVERDUE: 'danger',
    FAIL: 'danger',
    DAMAGED: 'danger'
  }
  return map[value] || 'info'
}

function resetForm() {
  Object.keys(form).forEach((key) => delete form[key])
  props.config.formFields.forEach((field) => {
    form[field.prop] = field.default ?? null
  })
}

async function loadData() {
  loading.value = true
  try {
    rows.value = await request.get(`${props.config.api}/list`)
    applyFilter()
  } finally {
    loading.value = false
  }
}

function applyFilter() {
  activeKeyword.value = keyword.value
  page.value = 1
}

function openCreate() {
  editingId.value = null
  resetForm()
  dialogVisible.value = true
}

function openEdit(row) {
  editingId.value = row[props.config.rowKey]
  resetForm()
  props.config.formFields.forEach((field) => {
    form[field.prop] = row[field.prop] ?? null
  })
  dialogVisible.value = true
}

async function submit() {
  const payload = {}
  props.config.formFields.forEach((field) => {
    payload[field.prop] = form[field.prop]
  })
  if (editingId.value) {
    await request.put(`${props.config.api}/${editingId.value}`, payload)
  } else {
    await request.post(props.config.api, payload)
  }
  ElMessage.success('保存成功')
  dialogVisible.value = false
  await loadData()
}

async function remove(row) {
  await ElMessageBox.confirm('确认删除这条记录吗？', '删除确认', { type: 'warning' })
  await request.delete(`${props.config.api}/${row[props.config.rowKey]}`)
  ElMessage.success('删除成功')
  await loadData()
}

onMounted(loadData)
</script>

<style scoped>
.crud-table {
  overflow: hidden;
  border: 1px solid #edf1f6;
}

.row-actions {
  display: flex;
  align-items: center;
  gap: 6px;
}

.pagination-row {
  display: flex;
  justify-content: flex-end;
  margin-top: 14px;
}

@media (max-width: 760px) {
  .toolbar-left {
    flex-wrap: wrap;
  }
}
</style>
