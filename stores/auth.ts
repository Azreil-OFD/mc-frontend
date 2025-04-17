import { defineStore } from 'pinia'
import { ref } from 'vue'

export const useAuthStore = defineStore('auth', () => {
  const token = ref<string | null>(null)
  const loggedIn = ref(false)

  function login(username: string, password: string) {
    if (username === 'player123' && password === 'secretpassword') {
      token.value = 'mock-jwt-token-123'
      loggedIn.value = true
      return { status: true, token: token.value }
    } else {
      throw { status: false, message: 'Неверные учетные данные' }
    }
  }

  function logout() {
    token.value = null
    loggedIn.value = false
  }

  return { token, loggedIn, login, logout }
})
