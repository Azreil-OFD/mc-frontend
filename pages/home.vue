<template>
  <Toast />
  <img src="../assets/img/loginButton.svg" class="logButton" @click="navigateTo('/login')" >

  <div class="wrapper">
    <div class="book">
      <div
        class="page"
        v-for="(page, index) in visiblePages"
        :key="index"
        v-show="page"
        
      >
        <p @click="() => {
          if(index === 0) {
            prevPages()
          } else {
            nextPages()
          }
        }">{{ page }}</p>
      </div>
    </div>
  <DownloadButton :toast="toast" />
  </div>

</template>

<script setup>
import DownloadButton from '~/components/DownloadButton.vue'
const toast = useToast()

const fullText = ref(`Инструкция к действиям

Я не знаю какие тут должны быть инструкции.
По-этому пускай тут будет просто текст.
Возможно я делаю что-то не так.
А возможно все так, но это не точно.
Возможно стоит добавить сплошной текст.
Противоположная точка зрения подразумевает, что непосредственные участники технического прогресса будут подвергнуты целой серии независимых исследований. 
Независимо, интерактивные прототипы освещают чрезвычайно интересные особенности картины в целом, 
однако конкретные выводы, разумеется, совершенно верифицированы.

Я не знаю какие тут должны быть инструкции.
По-этому пускай тут будет просто текст.
Возможно я делаю что-то не так.
А возможно все так, но это не точно.
Возможно стоит добавить сплошной текст.
Противоположная точка зрения подразумевает, что непосредственные участники технического прогресса будут подвергнуты целой серии независимых исследований. 
Независимо, интерактивные прототипы освещают чрезвычайно интересные особенности картины в целом, 
однако конкретные выводы, разумеется, совершенно верифицированы.
`)

const pages = ref([])
const currentIndex = ref(0)

const visiblePages = computed(() => {
  return [
    pages.value[currentIndex.value] || '',
    pages.value[currentIndex.value + 1] || " ".repeat(pages.value[currentIndex.value] !== null? '1' : '1')
  ]
})

function splitTextIntoPages() {
  const container = document.createElement('div')
  container.style.position = 'absolute'
  container.style.visibility = 'hidden'
  container.style.width = '50vh'
  container.style.minWidth = '50vh'
  container.style.height = 'auto'
  container.style.fontSize = '2vh'
  container.style.lineHeight = '1.4'
  container.style.fontFamily = 'McFont, sans-serif'
  container.style.padding = '8cap 5cap'
  container.style.boxSizing = 'border-box'
  container.style.whiteSpace = 'pre-wrap'
  document.body.appendChild(container)

  const words = fullText.value.split(' ')
  let currentPage = ''
  pages.value = []

  for (let i = 0; i < words.length; i++) {
    const testText = currentPage + (currentPage ? ' ' : '') + words[i]
    container.innerText = testText

    if (container.offsetHeight <= window.innerHeight * 0.9) {
      currentPage = testText
    } else {
      pages.value.push(currentPage.trim())
      currentPage = words[i]
    }
  }

  if (currentPage) {
    pages.value.push(currentPage.trim())
  }

  document.body.removeChild(container)
  currentIndex.value = 0
}

function nextPages() {
  if (currentIndex.value + 2 < pages.value.length) {
    currentIndex.value += 2
  } else if (currentIndex.value + 1 < pages.value.length) {
    currentIndex.value += 1
  }
}

function prevPages() {
  if (currentIndex.value - 2 >= 0) {
    currentIndex.value -= 2
  } else {
    currentIndex.value = 0
  }
}

onMounted(splitTextIntoPages)
watch(fullText, splitTextIntoPages)

</script>

<style scoped>


@font-face {
  font-family: 'McFont';
  src: url('@/assets/fonts/McFont.ttf') format('truetype');
}

.wrapper {
  background-image: url('@/assets/img/back.svg');
  background-repeat: no-repeat;
  background-size: contain;
  background-position: center;
  background-color: #73A920;
  height: 100%;
}

.logButton {
  position: absolute;
  height: 7cap;
  width: 7cap;
  z-index: 10;
  right: 1cap;
  top: 1cap;
}

.wrapper {
  display: flex;
  justify-content: center;
  align-items: center;
  font-family: 'McFont', sans-serif;
  flex-direction: column;
}

.book {
  display: flex;
  background-color: transparent;
  background-image: url('@/assets/img/book.png');
  background-repeat: no-repeat;
  background-size: contain;
  background-position: center;
  gap: 4px;
}

.page {
  width: 50vh;
  max-height: 100%;
  height: 99vh;
  padding: 9cap 3cap;
  padding-bottom: 10cap;
  font-size: 2vh;
  white-space: pre-wrap;
  box-sizing: border-box;
  overflow: hidden;
}

.page p {
  height: 90%;
  width: 100%;
  padding: 1vh;
  user-select: none;
}

</style>
