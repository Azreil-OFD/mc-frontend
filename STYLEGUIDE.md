# 🧭 Nuxt 3 Project Style Guide

> Этот документ определяет соглашения по структуре проекта, написанию компонентов, страниц, утилит, состояний и общему стилю разработки для проекта на Nuxt 3.

---

## 📁 Структура проекта

```
mc-frontend/
├── assets/            # Стили, шрифты, изображения
├── components/        # Vue-компоненты
├── composables/       # Повторно используемые хуки (use*)
├── content/           # Контент markdown/JSON
├── layouts/           # Layout-шаблоны
├── middleware/        # Middleware-файлы
├── pages/             # Страницы
├── plugins/           # Плагины
├── public/            # Публичные ассеты
├── stores/            # Состояния Pinia
├── types/             # Типы TS
├── utils/             # Утилиты/хелперы
├── nuxt.config.ts     # Nuxt конфиг
└── tsconfig.json      # TypeScript конфиг
```

---

## 📦 Компоненты (`/components`)

Категории:
- `base/` — базовые (например, `BaseButton.vue`)
- `layout/` — header, footer и т.п.
- `sections/` — секции страниц
- `ui/` — всплывашки, модалки

Соглашения:
- `PascalCase` для имён
- `<script setup lang="ts">`
- `scoped` стили по умолчанию

---

## 📄 Страницы (`/pages`)

- Используется авто-роутинг
- Структурируй по вкладкам или логике
- Пример:
  - `/pages/index.vue`
  - `/pages/profile/index.vue`
  - `/pages/profile/settings.vue`

---

## 🧩 Компосейблы (`/composables`)

- Названия начинаются с `use`
- Разделяй по смыслу: `useAuth.ts`, `useModal.ts`, `useFetchData.ts`

---

## 🧠 Состояние: Pinia (`/stores`)

### Структура

- Один файл = один store
- Именование: `useXxxStore.ts`  
  _Пример:_ `useUserStore.ts`, `useCartStore.ts`

### Пример:

```ts
// stores/useUserStore.ts
import { defineStore } from 'pinia'

export const useUserStore = defineStore('user', {
  state: () => ({
    name: '',
    token: '',
  }),
  actions: {
    setUser(data: { name: string; token: string }) {
      this.name = data.name
      this.token = data.token
    },
  },
})
```

### Рекомендации

- Храни только нужные данные
- Избегай тяжёлой логики в store
- Используй `defineStore` с типами

---

## 🔧 Утилиты (`/utils`)

- Названия: `camelCase`
- Структурируй по папкам: `api/`, `formatting/`, `validators/`
- Чистые функции без сайд-эффектов

---

## 📚 Типы (`/types`)

- Все глобальные и локальные типы
- Расширения: `.ts` или `.d.ts`
- Используй везде типизацию props, emit и т.д.

---

## 🧱 Плагины (`/plugins`)

- Расширения Nuxt (например, toast, axios)
- Зарегистрируй в `nuxt.config.ts`

---

## 🧪 Тестирование

- Размещать рядом с компонентами или в `__tests__/`
- Используй Jest или Vitest

---

## 🧼 Общие принципы

- Писать на `TypeScript`
- Использовать `<script setup lang="ts">`
- Следовать единым соглашениям по стилю
- Один компонент = одна ответственность

---

## ✨ Conventional Commits

- `feat:` новая фича
- `fix:` багфикс
- `refactor:` улучшение без нового функционала
- `chore:` тех. обновления (зависимости и т.п.)

Примеры:
- `feat: добавлен useUserStore с логикой авторизации`
- `fix: исправлено поведение модалки в Safari`

---

**Документ будет дополняться по мере развития проекта.**
