<template>
  <el-tabs>
    <el-tab-pane label="物品台账">
      <CrudPage :config="itemConfig" />
    </el-tab-pane>
    <el-tab-pane label="借用记录">
      <CrudPage :config="itemBorrowConfig" />
    </el-tab-pane>
  </el-tabs>
</template>

<script setup>
import CrudPage from '../components/CrudPage.vue'
import { itemBorrowConfig, itemConfig } from '../config/modules'
</script>
