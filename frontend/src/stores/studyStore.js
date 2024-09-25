import { defineStore } from 'pinia';

// Pinia 스토어 정의
export const useStudyStore = defineStore('study', {
  state: () => ({
    studyContent: '', // study.vue의 데이터를 저장할 변수
  }),
  actions: {
    setStudyContent(content) {
      this.studyContent = content; // 데이터를 저장하는 액션
    },
  },
});
