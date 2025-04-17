// stores/health.ts
import { defineStore } from 'pinia'

export const useHealthStore = defineStore('health', () => {
  function checkHealth() {
    return { status: true, message: 'OK' }
  }

  return { checkHealth }
})
