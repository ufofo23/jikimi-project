<template>
  <div class="card">
    <h3>{{ commonPieceSense }}</h3>
    <p>번호: {{ commonSenseNo }}</p>
    {{ commonSenseContent }}
  </div>
</template>

<script setup>
// 카드 컴포넌트는 props를 통해 데이터를 받음
const props = defineProps({
  commonSenseTitle: String,
  commonSenseNo: Number,
  commonSenseContent: String,
  commonPieceSense: String,
});

// 상세보기 클릭 시 부모로 이벤트 전파
const showDetail = () => {
  emit('show-detail', commonSenseNo);
};
</script>

<style scoped>
.card {
  padding: 20px;
  background-color: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
  text-align: center;
  width: auto;
  min-height: auto;
}

.card h3 {
  margin-bottom: 10px;
  font-size: 1.5rem;
}

.card p {
  margin-bottom: 20px;
  color: #555;
}

.btn-primary {
  background-color: #007bff;
  color: white;
  border: none;
  padding: 10px 15px;
  cursor: pointer;
  border-radius: 5px;
}

.btn-primary:hover {
  background-color: #0056b3;
}
</style>
