<template>
    <div class="container">
        <!-- 왼쪽 컴포넌트 (주소검색, 즐겨찾기 리스트, 매물 리스트) -->
        <div class="left-sidebar">
            <button>주소 검색</button>
            <button @click="toggleFavorites">즐겨찾기 리스트 (toggle)</button>
            <div>매물 리스트</div>
        </div>
    </div>
</template>

<script setup>
</script>

<style lang="scss" scoped>
.container {
  display: flex;
  height: 100vh; /* 화면의 높이를 100%로 */
}

.left-sidebar {
  width: 25%; /* 왼쪽 영역 비율 */
  padding: 10px;
  border-right: 2px solid #ddd; /* 경계선 추가 */
  box-sizing: border-box;
}
</style>