<template>
  <el-tabs>
    <el-tab-pane label="值日安排">
      <CrudPage :config="dutyConfig" />
    </el-tab-pane>
    <el-tab-pane label="检查记录">
      <CrudPage :config="dutyRecordConfig" />
    </el-tab-pane>
  </el-tabs>
</template>

<script setup>
import CrudPage from '../components/CrudPage.vue'
import { dutyConfig, dutyRecordConfig } from '../config/modules'
</script>
