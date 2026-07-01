<template>
  <div class="arabic-focus" dir="rtl">
    <Focus
      :sentence="'سلام عليك بما صبرتم و رابطتم و ثبتم في وجه الطغيان'"
      :border-color="'#22d3ee'"
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
