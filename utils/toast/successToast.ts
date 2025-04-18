import type { ToastServiceMethods } from "primevue/toastservice";

export default (toast: ToastServiceMethods, text: string) => {
  toast.add({ severity: 'success', summary: 'Успешно', detail: text, life: 5000 });
};