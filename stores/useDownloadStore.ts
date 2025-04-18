// stores/download.ts
import { defineStore } from 'pinia'

export const useDownloadStore = defineStore('download', () => {
  function downloadArchive(): Blob | { status: false; message: string } {
    const archiveExists = Math.random() < 0.5

    if (archiveExists) {
      return new Blob(['zip-content'], { type: 'application/zip' })
    } else {
      return { status: false, message: 'Архив не найден' }
    }
  }

  return { downloadArchive }
})
