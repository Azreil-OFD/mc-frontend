import type { ToastServiceMethods } from "primevue/toastservice";

export default (toast: ToastServiceMethods, text: string) => {
  toast.add({ severity: 'error', summary: 'Ошибка', detail: text, life: 5000 });
};