// stores/online.ts
import { defineStore } from 'pinia'
import { ref } from 'vue'

export const useOnlineStore = defineStore('online', () => {
  const users = ref([
    { id: 'player123', username: 'Player One', online: true },
    { id: 'player456', username: 'Player Two', online: false, lastSeen: 1712400300 },
  ])

  function getUsers(options: { onlyOnline?: boolean | null; search?: string } = {}) {
    const { onlyOnline = null, search = '' } = options
    return {
      status: true,
      users: users.value.filter(user => {
        const matchOnline = onlyOnline === null || user.online === onlyOnline
        const matchSearch = user.username.toLowerCase().includes(search.toLowerCase())
        return matchOnline && matchSearch
      }),
    }
  }

  return { users, getUsers }
})
