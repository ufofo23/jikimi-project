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
    <div v-if="selectedProperty && selectedProperty.length">
      <h2>아파트명: {{ selectedProperty[0].apartName }}</h2>
      <h4>
        도로명 주소: {{ selectedProperty[0].doroJuso }}
      </h4>
      <h5>건축년도: {{ selectedProperty[0].buildYear }}</h5>

      <table>
        <thead>
          <tr>
            <th>계약일자</th>
            <th>거래가격</th>
            <th>면적</th>
            <th>층수</th>
            <th>거래유형</th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="(property, index) in selectedProperty"
            :key="index"
          >
            <td>{{ property.date }}</td>
            <td>{{ property.price }}만원</td>
            <td>{{ property.spacial }} m²</td>
            <td>{{ property.floor }}</td>
            <td>{{ property.typeTrade }}</td>
          </tr>
        </tbody>
      </table>
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
