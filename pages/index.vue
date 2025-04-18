<template>
<LoginButton/>
</template>

<script setup>
definePageMeta({
  middleware: () => {
    const user = useLocalStorage('token', null)
    if (user.value) {
      return navigateTo('/dashboard')
    } else {
        return navigateTo('/home')
    }
  }
})
</script>
