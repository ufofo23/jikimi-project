import './assets/main.css';

import { createApp } from 'vue';
import { createPinia } from 'pinia';

import App from './App.vue';
import router from './router';
import './assets/style.css'; // 커스텀 CSS 불러오기

import { library } from '@fortawesome/fontawesome-svg-core';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
import { faCircleQuestion } from '@fortawesome/free-regular-svg-icons';
import { faCircleQuestion as faSolidCircleQuestion } from '@fortawesome/free-solid-svg-icons';

// 필요한 아이콘을 라이브러리에 추가
library.add(faCircleQuestion, faSolidCircleQuestion);

const app = createApp(App);
const pinia = createPinia();

app.use(pinia); // 이미 생성한 pinia 사용
app.use(router);

app.mount('#app');
