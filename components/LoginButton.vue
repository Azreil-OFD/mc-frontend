<template>
  <button
    @mousedown="isActive = true"
    @mouseup="isActive = false"
    @mouseleave="isActive = false"
    class="login-button"
    :class="{ active: isActive }"
  >
    Войти
  </button>
</template>

<script setup lang="ts">


const props = defineProps<{
  click: any
}>()


const isActive = ref(false)
watch(isActive, async () => {
  if (isActive.value) {
    try {
      await props.click?.()
    } catch (err) {
      console.error('Ошибка в click handler:', err)
    }
  }
})
</script>

<style scoped>
@font-face {
  font-family: 'McFont';
  src: url('@/assets/fonts/McFont.ttf') format('truetype');
}

.login-button {
  font-family: 'McFont', sans-serif;
  font-size: 24px;
  letter-spacing: 1px;
  padding: 10px 30px;
  border: 2px solid #e7f3d8;
  background-color: transparent;
  color: #ffffff;
  text-transform: uppercase;
  transition: background-color 0.2s ease;
  box-shadow: 2px 2px 0 #000;
}


.login-button:hover {
  background-color: #7ea4162d;
  border-color: #ffffff;
  color: #ffffff;
}

.login-button.active {
  background-color: #7da416;
  border-color: #ffffff;
  color: #ffffff;
}

</style>
