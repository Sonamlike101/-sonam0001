<template>
  <CrudPage :config="logConfig" />
</template>

<script setup>
import CrudPage from '../components/CrudPage.vue'
import { logConfig } from '../config/modules'
</script>
