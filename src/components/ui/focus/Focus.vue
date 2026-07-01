<template>
  <div
    ref="containerRef"
    class="focus-container"
  >
    <span
      v-for="(word, index) in words"
      :key="`${word}_${index}`"
      :ref="(el) => setRef(el as HTMLSpanElement, index)"
      class="focus-word"
      :class="{ manual: props.manualMode }"
      :style="{
        filter: index === currentIndex ? `blur(0px)` : `blur(${blurAmount}px)`,
        transition: `filter ${animationDuration}s ease`,
        '--border-color': borderColor,
      }"
      @mouseenter="handleMouseEnter(index)"
      @mouseleave="handleMouseLeave"
    >
      {{ word }}
    </span>
    <div
      class="focus-frame"
      :style="{
        '--border-color': borderColor,
        width: `${focusRect.width}px`,
        height: `${focusRect.height}px`,
        opacity: currentIndex >= 0 ? 1 : 0,
        transform: `translate(${focusRect.x}px, ${focusRect.y}px)`,
      }"
    >
      <span class="corner top-left" />
      <span class="corner top-right" />
      <span class="corner bottom-left" />
      <span class="corner bottom-right" />
    </div>
  </div>
</template>

<script lang="ts" setup>
import { computed, nextTick, onMounted, ref, watch } from "vue";
import { useIntervalFn } from "@vueuse/core";

interface FocusProps {
  sentence?: string;
  manualMode?: boolean;
  blurAmount?: number;
  borderColor?: string;
  animationDuration?: number;
  pauseBetweenAnimations?: number;
}

interface FocusRect {
  x: number;
  y: number;
  width: number;
  height: number;
}

const props = withDefaults(defineProps<FocusProps>(), {
  sentence: "Inspira Focus",
  manualMode: false,
  blurAmount: 8,
  borderColor: "#ef4444",
  animationDuration: 0.5,
  pauseBetweenAnimations: 1,
});

const words = computed(() => props.sentence.split(" "));
const containerRef = ref<HTMLElement | null>(null);
const wordRefs = ref<{ [key: number]: HTMLElement | null }>({});
const currentIndex = ref(0);
const focusRect = ref<FocusRect>({ x: 0, y: 0, width: 0, height: 0 });

function setRef(el: HTMLElement, index: number) {
  if (!el) return;
  wordRefs.value[index] = el;
}

function handleMouseEnter(index: number) {
  if (props.manualMode) {
    currentIndex.value = index;
  }
}
function handleMouseLeave() {
  if (props.manualMode) {
    currentIndex.value = 0;
  }
}

watch(
  currentIndex,
  async (newIndex) => {
    await nextTick();
    if (newIndex === null || newIndex === -1) return;
    if (!wordRefs.value[newIndex] || !containerRef.value) return;

    const parentRect = containerRef.value.getBoundingClientRect();
    const wordRect = wordRefs.value[newIndex].getBoundingClientRect();

    focusRect.value = {
      x: wordRect.left - parentRect.left,
      y: wordRect.top - parentRect.top,
      width: wordRect.width,
      height: wordRect.height,
    };
  },
  { immediate: true },
);

onMounted(() => {
  if (!props.manualMode) {
    useIntervalFn(
      () => {
        currentIndex.value = (currentIndex.value + 1) % words.value.length;
      },
      props.animationDuration * 1000 + props.pauseBetweenAnimations * 1000,
      {
        immediate: true,
      },
    );
  }
});
</script>

<style scoped>
.focus-container {
  position: relative;
  display: flex;
  gap: 1em;
  justify-content: center;
  align-items: center;
  flex-wrap: wrap;
  white-space: normal;
  text-align: center;
  width: 100%;
}

/* Words */
.focus-word {
  position: relative;
  font-size: clamp(1.2rem, 6vw, 2.6rem);
  font-weight: 900;
  cursor: pointer;
  transition:
    filter 0.3s ease,
    color 0.3s ease;
}

.focus-word.active {
  filter: blur(1);
}

.focus-frame {
  position: absolute;
  top: 0;
  left: 0;
  pointer-events: none;
  box-sizing: content-box;
  border: none;
  transition:
    width 0.35s ease-out,
    height 0.35s ease-out,
    transform 0.35s ease-out,
    opacity 0.25s ease-out;
}

@media (max-width: 640px) {
  .focus-container {
    gap: 0.6em;
  }
}

.corner {
  position: absolute;
  width: clamp(0.6rem, 2.4vw, 0.9rem);
  height: clamp(0.6rem, 2.4vw, 0.9rem);
  border: 3px solid var(--border-color, #fff);
  filter: drop-shadow(0px 0px 4px var(--border-color, #fff));
  border-radius: 3px;
  transition: none;
}

.top-left {
  top: -10px;
  left: -10px;
  border-right: none;
  border-bottom: none;
}

.top-right {
  top: -10px;
  right: -10px;
  border-left: none;
  border-bottom: none;
}

.bottom-left {
  bottom: -10px;
  left: -10px;
  border-right: none;
  border-top: none;
}

.bottom-right {
  bottom: -10px;
  right: -10px;
  border-left: none;
  border-top: none;
}
</style>
