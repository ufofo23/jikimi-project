<template>
  <h1>리포트/분석</h1>
  <p>근데 이거 데이터베이스랑 연결해야하면 컴포넌트로 해야하나 ?_?</p>
  <div class="container">
    <!-- 버튼: 클릭하면 아래 세부 내용을 토글 -->
    <div @click="toggleDetails('contract')">
      <h3>평가 기준(1)</h3>
      <span v-if="openSection === 'contract'">▲</span>
      <span v-else>▼</span>
    </div>
    <div v-if="openSection === 'contract'">
      <p>지피티..</p>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';

const openSection = ref(null); // 어떤 섹션이 열려 있는지 저장하는 변수

// 해당 섹션을 클릭하면 openSection 값을 변경하는 함수
const toggleDetails = (section) => {
  openSection.value = openSection.value === section ? null : section;
};
</script>

<style lang="scss" scoped>
.container {
  width: 90%;
  margin: 0 auto;
  padding: 10px;
}

.container div {
  cursor: pointer;
  border-bottom: 1px solid #000000;
  padding: 10px 0;
}

h3 {
  display: inline-block;
  margin: 0;
}

span {
  float: right;
}
</style>
