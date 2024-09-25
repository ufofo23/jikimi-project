import './assets/main.css';

import { createApp } from 'vue';
import { createPinia } from 'pinia';

import App from './App.vue';
import router from './router';
import './assets/style.css'; // 커스텀 CSS 불러오기

const app = createApp(App);
const pinia = createPinia();

app.use(pinia); // 이미 생성한 pinia 사용
app.use(router);

app.mount('#app');
