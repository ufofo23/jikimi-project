import './assets/main.css';

import { createApp } from 'vue';
import { createPinia } from 'pinia';

import App from './App.vue';
import router from './router';

import { library } from '@fortawesome/fontawesome-svg-core';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
import { fas } from '@fortawesome/free-solid-svg-icons'; 
import { far } from '@fortawesome/free-regular-svg-icons'; 



// 필요한 아이콘을 라이브러리에 추가
library.add(fas, far);


const app = createApp(App);

// 아이콘 컴포넌트 등록
app.component('font-awesome-icon', FontAwesomeIcon); 

const pinia = createPinia();
app.use(pinia);
app.use(router);

app.mount('#app');
