<template>
  <div class="container">
    <table class="table">
      <thead>
        <tr>
          <th>번호</th>
          <th>카테고리</th>
          <th>제목</th>
          <th>조회 수</th>
          <th>즐겨찾기</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="item in items" :key="item.id">
          <td>{{ item.id }}</td>
          <td>{{ item.category }}</td>
          <td>{{ item.title }}</td>
          <td>{{ item.views }}</td>
          <td>
            <button
              class="btn"
              :class="item.isFavorite ? 'btn-danger' : 'btn-outline-primary'"
              @click="toggleFavorite(item.id)"
            >
              {{ item.isFavorite ? '★' : '☆' }}
            </button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
<script setup>
import { ref } from 'vue';

// 샘플 데이터 정의 -> 백 데이터 가져오깅!
const items = ref([
  {
    id: 1,
    category: '상식',
    title: '부동산 시장의 기본 용어',
    views: 150,
    isFavorite: false,
  },
  {
    id: 2,
    category: '시나리오',
    title: '전세 사기 예방을 위한 시나리오',
    views: 200,
    isFavorite: true,
  },
  {
    id: 3,
    category: '용어',
    title: '근저당과 압류의 차이점',
    views: 120,
    isFavorite: false,
  },
  {
    id: 4,
    category: '상식',
    title: '전세금 반환 보증 보험의 필요성',
    views: 180,
    isFavorite: false,
  },
  {
    id: 5,
    category: '시나리오',
    title: '이중 계약 사기 사례 분석',
    views: 220,
    isFavorite: true,
  },
]);

// 즐겨찾기 토글 메서드
const toggleFavorite = (id) => {
  const item = items.value.find((item) => item.id === id);
  if (item) {
    item.isFavorite = !item.isFavorite;
  }
};
</script>
<style>
.container {
  width: 100%;
  margin: 0 auto;
  padding: 10px;
}

.container div {
  cursor: pointer;
  border-bottom: 1px solid #ddd;
  padding: 10px 0;
}

h3 {
  display: inline-block;
  margin: 0;
}

span {
  float: right;
}

.table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 10px;
}

.table th,
.table td {
  border: 1px solid #ddd;
  padding: 8px;
  text-align: left;
}

.table th {
  background-color: #f2f2f2;
}
</style>
