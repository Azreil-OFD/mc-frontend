// stores/mods.ts
import { defineStore } from 'pinia'
import { Ref, ref } from 'vue'

export const useModStore = defineStore('mods', () => {
  const mods: Ref<{name: string, active: boolean}[]> = ref([
    { name: 'mod1.jar', active: true },
    { name: 'mod2.jar', active: false }
  ])

  function listMods() {
    return { status: true, mods: mods.value }
  }

  function uploadMods(files: File[]) {
    const uploaded: string[] = []
    const conflicts: string[] = []
    const invalid: string[] = []

    for (const file of files) {
      const name: String = file.name
      if(typeof name !== 'string') {
        continue
      }
      
      if (!name.endsWith('.jar')) {
        invalid.push(name)
      } else if (mods.value.some(mod => mod.name === name)) {
        conflicts.push(name)
      } else {
        mods.value.push({ name, active: true })
        uploaded.push(name)
      }
    }

    if (uploaded.length === 0 && (conflicts.length || invalid.length)) {
      return { status: false, message: 'Ни один файл не был загружен', uploaded, conflicts, invalid }
    }

    if (conflicts.length || invalid.length) {
      return { status: false, message: 'Некоторые файлы не были загружены', uploaded, conflicts, invalid }
    }

    return { status: true, message: 'Все файлы успешно загружены', uploaded }
  }

  return { mods, listMods, uploadMods }
})
