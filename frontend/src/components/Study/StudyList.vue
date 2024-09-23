<template>
    <table class="table">
        <thead>
            <tr>
                <th>번호</th>
                <th>카테고리(상식, 시나리오, 용어 중에서 1)</th>
                <th>제목</th>
                <th>조회 수 - 있으면 데이터베이스 필요하다는데 덜덜덜 ... 우짜지 ..</th>
                <th>즐겨찾기</th>
            </tr>
        </thead>
        <tbody>
          <!-- 동적 데이터를 for문 돌릴 자리! 그렇게 해서 내용 추가 -->
        </tbody>
    </table>
</template>

<script setup>
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

.table th, .table td {
  border: 1px solid #ddd;
  padding: 8px;
  text-align: left;
}

.table th {
  background-color: #f2f2f2;
}
</style>