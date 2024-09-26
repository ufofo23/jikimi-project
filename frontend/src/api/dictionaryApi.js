import api from '@/api';

const BASE_URL = '/api/dictionary';

export default {
  async getList() {
    const { data } = await api.get(BASE_URL);
    console.log('STUDY GET LIST: ', data);
    return data;
  },

  async get(no) {
    const { data } = await api.get(`${BASE_URL}/${no}`);
    console.log('STUDY GET', data);
    return data;
  },
};

//dto....
