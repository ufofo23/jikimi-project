import api from '@/api';

const BASE_URL = '/api/sense';

const headers = { 'Content-Type': 'multipart/form-data' };

export default {
  async getList(params) {
    const { data } = await api.get(BASE_URL, { params });
    console.log('STUDY GET LIST: ', data);
    return data;
  },

  async get(no) {
    const { data } = await api.get(`${BASE_URL}/${no}`);
    console.log('STUDY GET', data);
    return data;
  },
};
