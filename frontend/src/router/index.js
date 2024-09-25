import { createRouter, createWebHistory } from 'vue-router';
import Main from '../pages/app/Main.vue';
import Login from '../pages/Login.vue';
import Signup from '../pages/Signup.vue';
import MyPage from '../pages/Mypage.vue';
import Map from '../pages/app/Map.vue';
import Analyzing from '@/pages/app/Analyzing.vue';
import Study from '@/pages/app/Study.vue';
import FAQ from '@/pages/FAQ.vue';
import Loading from '@/pages/Loading.vue';
import FraudChecklist from '@/pages/FraudChecklist.vue';
import Introduce from '@/pages/app/Introduce.vue';
import OauthRedirectPage from '@/pages/OauthRedirectPage.vue';
import SenseDetailPage from '@/pages/study/SenseDetailPage.vue';
import SenseListPage from '@/pages/study/SenseListPage.vue';
import DictionaryListPage from '@/pages/study/dictionary/DictionaryListPage.vue';
import DictionaryDetailPage from '@/pages/study/dictionary/DictionaryDetailPage.vue';

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    { path: '/mypage', name: 'mypage', component: MyPage },
    { path: '/signup', name: 'signup', component: Signup },
    { path: '/map', name: 'map', component: Map },
    { path: '/analyzing', name: 'analyzing', component: Analyzing },
    { path: '/study', name: 'study', component: Study },
    { path: '/faq', name: 'faq', component: FAQ },
    { path: '/introduce', name: 'introduce', component: Introduce },
    { path: '/', name: 'main', component: Main },
    { path: '/login', name: 'login', component: Login },
    {
      path: '/oauth/redirected/:provider',
      name: 'OAuthRedirectPage',
      component: OauthRedirectPage,
    },
    {
      path: '/study/commonsense/detail/:no',
      name: 'senseDetailPage',
      component: SenseDetailPage,
    },
    {
      path: '/study/commonsense/list',
      name: 'senseListPage',
      component: SenseListPage,
    },
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
    {
      path: 'study/dictionary/list',
      name: 'dictionaryList',
      component: DictionaryListPage
    },
    {
      path: 'study/dictionary/detail/:no',
      name: 'dictionaryDetailPage',
      component: DictionaryDetailPage
    }
  ],
});

export default router;
