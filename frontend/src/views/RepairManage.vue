<template>
  <el-tabs>
    <el-tab-pane label="报修单">
      <CrudPage :config="repairConfig" />
    </el-tab-pane>
    <el-tab-pane label="处理记录">
      <CrudPage :config="repairProcessConfig" />
    </el-tab-pane>
  </el-tabs>
</template>

<script setup>
import CrudPage from '../components/CrudPage.vue'
import { repairConfig, repairProcessConfig } from '../config/modules'
</script>
