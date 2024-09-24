<script setup>
import { useRoute, useRouter } from 'vue-router';
import api from '@/api/boardApi';
import { ref } from 'vue';
import moment from 'moment';

const cr = useRoute();
const router = useRouter();

const no = cr.params.no;
const article = ref({});

const back = () => {
  router.push({ name: 'sense/list', query: cr.query });
};

const load = async () => {
  article.value = await api.get(no);
  console.log('DETAIL', item.value);
};

load();
</script>

<template>
  <h1>{{ item.title }}</h1>
  <div class="my-3 d-flex justify-content-between"></div>

  <div class="content">{{ item.content }}</div>

  <div class="my-5">
    <button class="btn btn-primary me-2" @click="back">
      <i class="fa-solid fa-list"></i> 목록
    </button>
  </div>
</template>

<style scoped>
.attach {
  font-size: 0.8rem;
  cursor: pointer;
}
.content {
  white-space: pre-line;
}
</style>
