<template>
  <div>
    дашборд
  </div>
</template>

<script lang="ts" setup>
definePageMeta({
  middleware: () => {
    const user = useLocalStorage('token', null)
    if (!user.value) {
      return navigateTo('/home')
    }
  }
})
</script>

<style>

</style>