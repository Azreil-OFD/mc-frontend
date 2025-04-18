<template>
  <div id="inverse-cursor"></div>

  <div>
    <slot />
  </div>
</template>

<script setup>
onMounted(() => {
  document.addEventListener('mousemove', (e) => {
  const cursor = document.getElementById('inverse-cursor');
  cursor.style.left = `${e.clientX}px`;
  cursor.style.top = `${e.clientY}px`;
});
})

</script>

<style>
#inverse-cursor {
  position: fixed;
  width: 16px;
  height: 16px;
  border-radius: 50%;
  pointer-events: none;
  background: white;
  mix-blend-mode: difference;
  z-index: 9999;
  transform: translate(-50%, -50%);
}


</style>