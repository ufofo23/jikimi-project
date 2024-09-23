import { createRouter, createWebHistory } from 'vue-router';
import Main from '../pages/Main.vue';
import Login from '../pages/Login.vue';
import Signup from '../pages/Signup.vue';
import MyPage from '../pages/Mypage.vue';
import Check from '../pages/Check.vue';
import Map from '../pages/Map.vue';
import Analyzing from '@/pages/Analyzing.vue';
import Study from '@/pages/Study.vue';
import FAQ from '@/pages/FAQ.vue';
import Loading from '@/pages/Loading.vue';
import FraudChecklist from '@/pages/FraudChecklist.vue';
import Introduce from '@/pages/Introduce.vue';

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    { path: '/', name: 'main', component: Main },
    { path: '/login', name: 'login', component: Login },
    { path: '/mypage', name: 'mypage', component: MyPage },
    { path: '/signup', name: 'signup', component: Signup },
    { path: '/check', name: 'check', component: Check },
    { path: '/map', name: 'map', component: Map },
    { path: '/analyzing', name: 'analyzing', component: Analyzing },
    { path: '/study', name: 'study', component: Study },
    { path: '/faq', name: 'faq', component: FAQ },
    { path: '/introduce', name: 'introduce', component: Introduce },
    {
      path: '/fraudchecklist',
      name: 'fraudchecklist',
      component: FraudChecklist,
    },
    {
      path: '/loading',
      name: 'Loading',
      component: Loading,
    },
  ],
});

export default router;
