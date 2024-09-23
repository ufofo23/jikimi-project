<template>
  <div>
    <h1>Study 페이지</h1>
    <div v-if="studyData">
      <p>{{ studyData.title }}</p>
      <p>{{ studyData.content }}</p>
    </div>
  </div>
</template>

<script>
import studyApi from '@/api/studyApi';

export default {
  data() {
    return {
      studyData: null,
    };
  },
  async created() {
    try {
      this.studyData = await studyApi.getStudyData(); // study 페이지의 데이터를 로드
    } catch (error) {
      console.error('데이터 로드 실패', error);
    }
  },
};
</script>
