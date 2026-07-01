<template>
  <div class="arabic-focus" dir="rtl">
    <Focus
      :sentence="'سلام على أرواح شهدائنا و أطفالنا الأبرياء و أهلنا المظلومين'"
      :manual-mode="true"
      :border-color="'#f472b6'"
    />
  </div>
</template>

<script setup lang="ts">
import { Focus } from ".";
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Cairo:wght@400;600;700&display=swap");

.arabic-focus {
  direction: rtl;
  font-family: "Cairo", "Noto Naskh Arabic", system-ui, -apple-system, sans-serif;
  text-align: center;
  width: 100%;
}
</style>
