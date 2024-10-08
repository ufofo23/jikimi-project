<template>
  <div class="container">
    <table class="table">
      <thead>
        <tr>
          <th>번호</th>
          <th>제목</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="article in articles" :key="article.commonSenseNo">
          <td>{{ article.commonSenseNo }}</td>
          <td>{{ article.commonSenseTitle }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
<script setup>
import { ref } from 'vue';
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
