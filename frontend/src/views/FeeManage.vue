<template>
  <el-tabs>
    <el-tab-pane label="费用账单">
      <CrudPage :config="feeConfig" />
    </el-tab-pane>
    <el-tab-pane label="缴费记录">
      <CrudPage :config="feePaymentConfig" />
    </el-tab-pane>
    <el-tab-pane label="费用类型">
      <CrudPage :config="feeTypeConfig" />
    </el-tab-pane>
  </el-tabs>
</template>

<script setup>
import CrudPage from '../components/CrudPage.vue'
import { feeConfig, feePaymentConfig, feeTypeConfig } from '../config/modules'
</script>
