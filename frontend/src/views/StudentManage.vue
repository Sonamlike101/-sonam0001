<template>
  <CrudPage :config="studentConfig" />
</template>

<script setup>
import CrudPage from '../components/CrudPage.vue'
import { studentConfig } from '../config/modules'
</script>
