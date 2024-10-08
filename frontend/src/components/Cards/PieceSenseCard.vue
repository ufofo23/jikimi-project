<template>
  <div
    class="bg-green-300 w-64 h-32 m-8 static rounded-lg"
    @click="detail(currentCommonSenseNo)"
  >
    <div
      class="bg-white w-64 h-40 hover:-m-2 absolute rounded-lg shadow-lg hover:shadow-2xl transition-all duration-150 ease-out hover:ease-in"
    >
      <h1 class="m-4 text-sm font-bold">오늘의 토막 상식 🏡</h1>
      <hr class="m-4 rounded-2xl border-t-2" />
      <div class="m-4 text-2xl">
        <!-- 현재 pieceSense가 있으면 출력, 없으면 로딩 메시지 -->
        <div v-if="commonPieceSense">
          <p>{{ commonPieceSense }}</p>
        </div>
        <p v-else>로딩 중...</p>
      </div>
    </div>
  </div>
</template>

<script setup>
import { defineProps, defineEmits } from 'vue';

const props = defineProps({
  commonSenseTitle: String,
  commonSenseNo: Number,
  commonPieceSense: String,
});

const emits = defineEmits(['detail']);

// 카드 클릭 시 상세 페이지로 이동하는 함수
const detail = (no) => {
  router.push({
    name: 'senseDetailPage',
    params: { no: no },
  });
};
</script>

<style scoped>
.card-image {
  position: absolute;
  right: 20px;
  bottom: 20px;
  width: 120px;
  height: auto;
  opacity: 0.9;
}

/* hover 스타일 및 카드의 이동 효과 */
.bg-white:hover {
  transform: scale(1.08);
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
}
</style>
