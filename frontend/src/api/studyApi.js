// studyApi.js
import api from '@/api';

const BASE_URL = '/api/study';

export default {
  async getStudyData() {
    const { data } = await api.get(BASE_URL);
    return data; // 백엔드에서 제공한 데이터를 반환
  },
};
