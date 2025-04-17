<template>
  <div class="container mx-auto p-4">
    <h1 class="text-4xl font-bold mb-8">{{ title }}</h1>

    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4">
      <div v-for="(author, index) in autors" :key="index" class="flex flex-col items-center border p-4 rounded-lg">
        <img :src="author.photo" :alt="author.name" class="w-24 h-24 object-cover rounded-full mb-2" />
        <span class="text-lg font-medium">{{ author.name }}</span>
      </div>
    </div>

    <div class="mt-8">
      <label for="">Кликер</label>
      <input v-model="storedValue" type="text" placeholder="Введите значение" class="border p-2 rounded-md w-full mb-2"
        disabled />
      <button @click="addValue" class="bg-blue-500 text-white py-2 px-4 rounded-md hover:bg-blue-600 w-full">
        +
      </button>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useLocalStorage } from '@vueuse/core'

const title = ref('Название проекта')

const autors = ref([
  { name: 'Иван Иванов', photo: 'https://e7.pngegg.com/pngimages/527/663/png-clipart-logo-person-user-person-icon-rectangle-photography-thumbnail.png' },
  { name: 'Пётр Петров', photo: 'https://e7.pngegg.com/pngimages/527/663/png-clipart-logo-person-user-person-icon-rectangle-photography-thumbnail.png' },
  { name: 'Сергей Сергеев', photo: 'https://e7.pngegg.com/pngimages/527/663/png-clipart-logo-person-user-person-icon-rectangle-photography-thumbnail.png' },
])

const storedValue = useLocalStorage('storedValue', 0)

const addValue = () => {
  storedValue.value += 1
}
</script>
