<template>
  <div>
    <h1>Test Page</h1>
    <p>This is a simple test page to verify the application is working.</p>
    <p>Current time: {{ currentTime }}</p>
  </div>
</template>

<script setup>
const currentTime = ref(new Date().toLocaleString())

onMounted(() => {
  console.log('Test page mounted successfully')
})
</script>

<style scoped>
h1 {
  color: #2c3e50;
}
p {
  margin: 10px 0;
}
</style>