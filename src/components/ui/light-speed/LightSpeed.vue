<template>
  <div
    ref="containerRef"
    class="w-full h-full overflow-hidden block"
  />
</template>

<script lang="ts" setup>
import { onMounted, ref } from "vue";
import type { LightSpeedOptions, LightSpeedProps } from "./LightSpeedApp";
import { defaultOptions, distortions, LightSpeedApp } from "./LightSpeedApp";

const props = defineProps<LightSpeedProps>();

const containerRef = ref<HTMLElement | null>(null);

onMounted(() => {
  if (!containerRef.value) return;

  const mergedOptions: LightSpeedOptions = {
    ...defaultOptions,
    ...(props.effectOptions || {}),
  };

  if (typeof mergedOptions.distortion === "string") {
    mergedOptions.distortion = distortions[mergedOptions.distortion];
  }

  const lightSpeedApp = new LightSpeedApp(containerRef.value, mergedOptions);
  lightSpeedApp.loadAssets().then(lightSpeedApp.init);
});
</script>
