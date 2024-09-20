import { createRouter, createWebHistory } from 'vue-router';
import Main from '../pages/Main.vue';
import Login from '@/pages/Login.vue';
import Signup from '../pages/Signup.vue';
import MyPage from '../pages/Mypage.vue';
import Check from '../pages/Check.vue';
import Info from '../pages/Info.vue';
import Map from '../pages/Map.vue';
import Analyzing from '@/pages/Analyzing.vue';
import Study from '@/pages/Study.vue';
import FAQ from '@/pages/FAQ.vue';
import OauthRedirectPage from '@/pages/OauthRedirectPage.vue';

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    { path: '/', name: 'main', component: Main },
    { path: '/login', name: 'login', component: Login },
    { path: '/oauth/redirected/:provider', name: 'OAuthRedirectPage', component: OauthRedirectPage},
    { path: '/mypage', name: 'mypage', component: MyPage },
    { path: '/signup', name: 'signup', component: Signup },
    { path: '/check', name: 'check', component: Check },
    { path: '/info', name: 'info', component: Info },
    { path: '/map', name: 'map', component: Map },
    { path: '/analyzing', name: 'analyzing', component: Analyzing },
    { path: '/study', name: 'study', component: Study },
    { path: '/faq', name: 'faq', component: FAQ },
  ],
});

export default router;
