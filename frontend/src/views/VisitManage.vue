<template>
  <el-tabs>
    <el-tab-pane label="来访记录">
      <CrudPage :config="visitConfig" />
    </el-tab-pane>
    <el-tab-pane label="访客信息">
      <CrudPage :config="visitorConfig" />
    </el-tab-pane>
  </el-tabs>
</template>

<script setup>
import CrudPage from '../components/CrudPage.vue'
import { visitConfig, visitorConfig } from '../config/modules'
</script>
