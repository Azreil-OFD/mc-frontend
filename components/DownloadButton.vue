<template>
  <button @mousedown="isActive = true" @mouseup="isActive = false" @mouseleave="isActive = false"
    class="download-button" :class="{ active: isActive }">
    СКАЧАТЬ <span class="version">v.1.1.1</span>
  </button>
</template>

<script setup lang="ts">
import { useDownloadStore } from '../stores/useDownloadStore';
import type { ToastServiceMethods } from "primevue/toastservice";
import successToast from '~/utils/toast/successToast';
const isActive = ref(false)

const props = defineProps<{
  toast: ToastServiceMethods
}>()


watch(isActive, () => {
  if (isActive.value === true) {
    const result = downloadStorage.downloadArchive()
    if (result instanceof Blob) {
      const url = URL.createObjectURL(result)
      const a = document.createElement('a')
      a.href = url
      a.download = 'mods.zip'
      document.body.appendChild(a)
      a.click()
      document.body.removeChild(a)
      URL.revokeObjectURL(url)
      successToast(props.toast, "Загрузка началась")
    } else {
      successToast(props.toast, "Ошибка скачивания")
    }
  }

})
const downloadStorage = useDownloadStore()

</script>

<style scoped>
@font-face {
  font-family: 'McFont';
  src: url('@/assets/fonts/McFont.ttf') format('truetype');
}

button {
  position: absolute;
  bottom: 2vh;
}


.download-button {
  font-family: 'McFont', monospace;
  font-size: 3cap;
  padding: 2vh 4vh;
  border: 3px solid #ffffff;
  background-color: #1a1a1a;
  color: #eafed8;
  text-transform: uppercase;
  display: flex;
  align-items: center;
  gap: 12px;
  transition: background-color 0.2s ease, color 0.2s ease;
}

.download-button .version {
  font-size: 16px;
  color: #eafed8;
  margin-left: 10px;
}

.download-button:active {
  background-color: #b1f060;
  border-color: #ffffff;
  color: #1a1a1a;
}

.download-button:active .version {
  color: #1a1a1a;
}

</style>
