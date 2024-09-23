import './assets/main.css';

import { createApp } from 'vue';
import { createPinia } from 'pinia';

import App from './App.vue';
import router from './router';
import './assets/style.css'; // 커스텀 CSS 불러오기

const app = createApp(App);
const pinia = createPinia();

app.use(createPinia());
app.use(router);
app.use(pinia); // Pinia를 Vue 애플리케이션에 추가

app.mount('#app');
