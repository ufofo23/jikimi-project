import api from '@/api';

const BASE_URL = '/api/map'; // 주소 데이터를 가져오는 URL
const headers = { 'Content-Type': 'application/json' };

export default {
  // 주소 리스트를 가져오는 함수
  async getAddressList() {
    const { data } = await api.get(BASE_URL, { headers });
    console.log('ADDRESS GET LIST: ', data);
    return data;
  },
};
