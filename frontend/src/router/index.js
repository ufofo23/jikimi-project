import { createRouter, createWebHistory } from 'vue-router';
<<<<<<< HEAD
import Main from '../pages/Main.vue';
import Login from '@/pages/Login.vue';
=======
import Main from '../pages/app/Main.vue';
import Login from '../pages/Login.vue';
>>>>>>> ed87022f1751b139d4533ee9ca8629b90b003aa1
import Signup from '../pages/Signup.vue';
import MyPage from '../pages/Mypage.vue';
import Map from '../pages/app/Map.vue';
import Analyzing from '@/pages/app/Analyzing.vue';
import Study from '@/pages/app/Study.vue';
import FAQ from '@/pages/FAQ.vue';
<<<<<<< HEAD
import OauthRedirectPage from '@/pages/OauthRedirectPage.vue';
=======
import Loading from '@/pages/Loading.vue';
import FraudChecklist from '@/pages/FraudChecklist.vue';
import Introduce from '@/pages/app/Introduce.vue';
>>>>>>> ed87022f1751b139d4533ee9ca8629b90b003aa1

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    { path: '/', name: 'main', component: Main },
    { path: '/login', name: 'login', component: Login },
    { path: '/oauth/redirected/:provider', name: 'OAuthRedirectPage', component: OauthRedirectPage},
    { path: '/mypage', name: 'mypage', component: MyPage },
    { path: '/signup', name: 'signup', component: Signup },
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
