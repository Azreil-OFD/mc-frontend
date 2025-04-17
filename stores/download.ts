// stores/download.ts
import { defineStore } from 'pinia'

export const useDownloadStore = defineStore('download', () => {
  function downloadArchive(): Blob | { status: false; message: string } {
    const archiveExists = true

    if (archiveExists) {
      return new Blob(['zip-content'], { type: 'application/zip' })
    } else {
      return { status: false, message: 'Архив не найден' }
    }
  }

  return { downloadArchive }
})
