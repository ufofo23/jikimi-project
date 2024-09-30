<template>
  <div class="left-panel">
    <button
      @click="$emit('toggle-panel')"
      class="toggle-btn"
    >
      닫기
    </button>
    <h2>찜목록</h2>
    <ul>
      <li>장소 1</li>
      <li>장소 2</li>
    </ul>
    <h2>상세보기</h2>
    <div v-if="selectedProperty">
      <h3>{{ selectedProperty.apartName }}</h3>
      <p>주소: {{ selectedProperty.doroJuso }}</p>
      <p>가격: {{ selectedProperty.price }}억</p>
      <p>면적: {{ selectedProperty.spacial }} m²</p>
      <p>
        계약년월일: {{ selectedProperty.conMonth }}
        {{ selectedProperty.conDate }}
      </p>
      <p>층수: {{ selectedProperty.floor }}</p>
      <p>건축년도: {{ selectedProperty.buildYear }}</p>
      <p>건물 타입: {{ selectedProperty.typeBuild }}</p>
    </div>
  </div>
</template>

<script setup>
const props = defineProps({
  selectedProperty: Object,
});

const emit = defineEmits(['toggle-panel']);
</script>

<style scoped>
.left-panel {
  width: 30%;
  padding: 20px;
  background-color: grey;
  position: relative;
}

.toggle-btn {
  position: absolute;
  top: 10px;
  right: 10px;
  background-color: blue;
  color: white;
  padding: 5px;
  cursor: pointer;
  border-radius: 5px;
}
</style>
