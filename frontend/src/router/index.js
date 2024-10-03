import { createRouter, createWebHistory } from 'vue-router';
import useAuthStore from '@/stores/auth';
import Main from '../pages/app/Main.vue';
import Login from '../pages/Login.vue';
import MyPage from '../pages/Mypage.vue';
// import Map from '../pages/app.vue';
import Analyzing from '@/pages/app/Analyzing.vue';
import Study from '@/pages/app/Study.vue';
import FAQ from '@/pages/FAQ.vue';
import Loading from '@/pages/Loading.vue';
import FraudChecklist from '@/pages/FraudChecklist.vue';
import Introduce from '@/pages/app/Introduce.vue';
import OauthRedirectPage from '@/pages/OauthRedirectPage.vue';
import SenseDetailPage from '@/pages/study/commonsense/SenseDetailPage.vue';
import SenseListPage from '@/pages/study/commonsense/SenseListPage.vue';
import DictionaryListPage from '@/pages/study/dictionary/DictionaryListPage.vue';
import DictionaryDetailPage from '@/pages/study/dictionary/DictionaryDetailPage.vue';
import MainMap from '../pages/map/MainMap.vue';
import BeforeCheckListPage from '@/pages/study/BeforeCheckListPage.vue';

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    { path: '/mypage', name: 'mypage', component: MyPage },
    // { path: '/map', name: 'map', component: Map },
    {
      path: '/analyzing',
      name: 'analyzing',
      component: Analyzing,
      meta: { requiresAuth: true },
    },
    {
      path: '/study',
      name: 'study',
      component: Study,
      meta: { requiresAuth: true },
    },
    { path: '/faq', name: 'faq', component: FAQ },
    {
      path: '/introduce',
      name: 'introduce',
      component: Introduce,
    },
    { path: '/', name: 'main', component: Main },
    { path: '/login', name: 'login', component: Login },
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
      path: '/study/dictionary/list',
      name: 'dictionaryList',
      component: DictionaryListPage,
    },
    {
      path: '/study/dictionary/detail/:no',
      name: 'dictionaryDetailPage',
      component: DictionaryDetailPage,
    },
    {
      path: '/map',
      name: 'map',
      component: MainMap,
    },
    {
      path: '/study/beforecheck/list',
      name: 'beforeCheckList',
      component: BeforeCheckListPage,
    },
  ],
});

router.beforeEach((to, from, next) => {
  const authStore = useAuthStore();
  const requiresAuth = to.matched.some((record) => record.meta.requiresAuth);

  authStore.checkAuth(); // 인증 체크

  if (requiresAuth && !authStore.isAuthenticated) {
    next('/login'); // 인증이 필요하지만 인증되지 않은 경우 로그인 페이지로 리다이렉트
  } else {
    next(); // 인증이 필요하지 않거나 인증된 경우 계속 진행
  }
});

export default router;
