<template>

  <div class="wrapper">
    <img v-if="error" src="../assets/img/creep.png" class="cree">
    <div class="login-box">
      <h1>ВХОД</h1>
      <label>
        Логин
        <input type="text" v-model="login" />
      </label>
      <label class="password-wrapper">
        Пароль
        <div class="password-field-container">
          <input type="text" class="custom-password" @keydown="handlePasswordInput" :value="maskedValue" />
        </div>
      </label>

      <LoginButton :click="loginHandler" />
    </div>
  </div>
</template>

<script setup lang="ts">
import LoginButton from '~/components/LoginButton.vue'


const login = ref('')
const password = ref('')
const maskedValue = ref('')
const authStore = useAuthStore()
const error = ref(false)
const token = useLocalStorage('token', null)
const loginHandler = async () => {
  error.value = false
  const result = await authStore.login(login.value, password.value)
  if (result.status) {
    token.value = result.token
    navigateTo('/')
  } else {
    error.value = true
  }
}


const handlePasswordInput = (e: KeyboardEvent) => {
  const isModifier = e.ctrlKey || e.metaKey || e.altKey
  const isServiceKey =
    e.key === 'Enter' ||
    e.key === 'Tab' ||
    e.key === 'Escape' ||
    e.key.startsWith('Arrow') ||
    e.key === 'CapsLock'
  if (isModifier || isServiceKey) {
    return
  }

  if (e.key === 'Backspace') {
    password.value = password.value.slice(0, -1)
  } else if (e.key.length === 1) {
    password.value += e.key
  } else {
    return
  }
  if (password.value.length !== maskedValue.value.length) {
    maskedValue.value = '*'.repeat(password.value.length)
  }
  if (maskedValue.value.length === 0) {
    password.value = ""
  }


  e.preventDefault()
  maskedValue.value = '*'.repeat(password.value.length)
}
</script>

<style scoped>
@font-face {
  font-family: 'McFont';
  src: url('@/assets/fonts/McFont.ttf') format('truetype');
}

.cree {
  position: absolute;
  z-index: 0;
  top: 0;
  left: 0;
}


.wrapper {
  background-image: url('@/assets/img/back.svg');
  background-repeat: no-repeat;
  background-size: contain;
  background-position: center;
  background-color: #73A920;
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  font-family: 'McFont', sans-serif;
}

.login-box {
  background-color: #1d1d1d;
  padding: 5vh 7vh;
  color: #ffffff;
  display: flex;
  flex-direction: column;
  gap: 20px;
  min-width: 300px;
  z-index: 2;
}

.login-box h1 {
  text-align: center;
  font-size: 32px;
  margin-bottom: 10px;
}

.login-box label {
  display: flex;
  flex-direction: column;
  font-size: 18px;
  position: relative;
}

.login-box input {
  margin-top: 8px;
  padding: 8px;
  background-color: #e0ffe0;
  border: none;
  font-family: 'McFont', sans-serif;
  font-size: 2vh;
  color: black;
}
</style>
