<script setup lang="ts">
import { onMounted, onUnmounted, ref } from 'vue';

const open = ref(false);
const dropdownButtonRef = ref<HTMLButtonElement | null>(null);

const toggleNavbar = () => {
  open.value = !open.value;
};

const navLinkItems = ref([
  { text: 'Home', href: 'javascript:void(0)' },
  { text: 'Payment', href: 'javascript:void(0)' },
  { text: 'About', href: 'javascript:void(0)' },
  { text: 'Blog', href: 'javascript:void(0)' },
]);

// Custom composition function to handle click outside
const handleClickOutside = (event: MouseEvent) => {
  if (
    dropdownButtonRef.value &&
    !dropdownButtonRef.value.contains(event.target as Node)
  ) {
    open.value = false;
  }
};

onMounted(() => {
  document.addEventListener('click', handleClickOutside);
});

onUnmounted(() => {
  document.removeEventListener('click', handleClickOutside);
});

const clients = ref([
  {
    name: 'Ayroui',
    logo: 'https://cdn.tailgrids.com/2.0/image/assets/images/brands/ayroui.svg',
    link: 'javascript:void(0)',
  },
  {
    name: 'GrayGrids',
    logo: 'https://cdn.tailgrids.com/2.0/image/assets/images/brands/graygrids.svg',
    link: 'javascript:void(0)',
  },
  {
    name: 'UIdeck',
    logo: 'https://cdn.tailgrids.com/2.0/image/assets/images/brands/uideck.svg',
    link: 'javascript:void(0)',
  },
]);
</script>

<template>
  <!-- ====== Navbar Section Start -->
  <header class="absolute top-0 left-0 z-50 w-full">
    <div class="container border-none">
      <div class="relative -mx-4 flex items-center justify-between border-none">
        <div class="w-60 max-w-full px-4 border-none">
          <a href="/#" class="block w-full py-5 border-none">
            <img src="@/assets/jikimi.png" alt="logo" class="dark:hidden" />

            <img
              src="https://cdn.tailgrids.com/2.0/image/assets/images/logo/logo-white.svg"
              alt="logo"
              class="hidden dark:block"
            />
          </a>
        </div>
        <div class="flex w-full items-center justify-between px-4 border-none">
          <div>
            <button
              @click="toggleNavbar"
              ref="dropdownButtonRef"
              id="navbarToggler"
              class="absolute right-4 top-1/2 block -translate-y-1/2 rounded-lg px-3 py-[6px] ring-primary focus:ring-2 lg:hidden border-none"
            >
              <span
                class="relative my-[6px] block h-[2px] w-[30px] bg-body-color dark:bg-white"
              ></span>
              <span
                class="relative my-[6px] block h-[2px] w-[30px] bg-body-color dark:bg-white"
              ></span>
              <span
                class="relative my-[6px] block h-[2px] w-[30px] bg-body-color dark:bg-white"
              ></span>
            </button>
            <nav
              :class="{ hidden: !open }"
              id="navbarCollapse"
              class="absolute right-4 top-full w-full max-w-[250px] rounded-lg bg-white dark:bg-dark-2 transition-all lg:static lg:bg-transparent lg:block lg:w-full lg:max-w-full lg:shadow-none xl:ml-11 lg:dark:bg-transparent border-none"
            >
              <ul class="block lg:flex border-none">
                <template v-for="(item, index) in navLinkItems" :key="index">
                  <li class="border-none">
                    <a
                      v-if="item.href"
                      :href="item.href"
                      class="flex py-2 text-base font-medium text-dark dark:text-white hover:text-primary lg:ml-10 lg:inline-flex border-none"
                    >
                      {{ item.text }}
                    </a>
                  </li>
                </template>
              </ul>
            </nav>
          </div>
          <div class="hidden justify-end pr-16 sm:flex lg:pr-0 border-none">
            <a
              href="/#"
              class="py-3 text-base font-medium px-7 text-dark dark:text-white hover:text-primary border-none"
              >Sign in</a
            >
            <a
              href="/#"
              class="py-3 text-base font-medium text-white rounded-md bg-primary px-7 hover:bg-blue-dark border-none"
              >Sign Up</a
            >
          </div>
        </div>
      </div>
    </div>
  </header>
  <!-- ====== Hero Section Start -->
  <div class="relative min-h-screen flex bg-gray-100 dark:bg-dark border-none">
    <!-- 왼쪽 섹션 -->
    <div
      class="flex-1 bg-white rounded-br-[100px] pt-[120px] pb-[110px] lg:pt-[150px] flex flex-col justify-center items-start px-8 lg:px-12 border-none"
    >
      <div class="hero-content border-none">
        <h1
          class="mb-5 text-4xl font-bold !leading-[1.208] text-dark dark:text-white sm:text-[42px] lg:text-[40px] xl:text-5xl border-none"
        >
          내 집은<br />
          안전할까? <br />
        </h1>
        <p class="mb-8 text-base text-body-color dark:text-dark-6 border-none">
          계약 진행 단계에 따라 반드시 필요한 체크리스트를 준비했어요. <br />
          지금 바로 확인해보세요!
        </p>
        <ul class="flex flex-wrap items-center border-none">
          <li class="border-none">
            <a
              href="javascript:void(0)"
              class="inline-flex items-center justify-center px-6 py-3 text-base font-medium text-center text-white rounded-md bg-primary hover:bg-blue-dark lg:px-7 border-none"
            >
              계약이 처음이라면?
            </a>
          </li>
          <li class="ml-4 border-none">
            <a
              href="javascript:void(0)"
              class="inline-flex items-center justify-center py-3 px-5 text-center text-base font-medium text-[#464646] dark:text-white hover:text-primary border-none"
            >
              <span class="mr-2 border-none"> </span>
              계약 진행/완료 상태라면!
            </a>
          </li>
        </ul>
        <div class="clients pt-16 border-none">
          <h6
            class="flex items-center mb-6 text-xs font-normal text-body-color dark:text-dark-6 border-none"
          >
            Some Of Our Clients
            <span
              class="inline-block w-8 h-px ml-3 bg-body-color border-none"
            ></span>
          </h6>
          <div class="flex items-center gap-4 xl:gap-[50px] border-none">
            <a
              v-for="(client, index) in clients"
              :key="index"
              :href="client.link"
              class="block py-3 border-none"
            >
              <img :src="client.logo" :alt="client.name" class="border-none" />
            </a>
          </div>
        </div>
      </div>
    </div>

    <!-- 오른쪽 섹션 -->
    <div
      class="flex-1 bg-gray-100 dark:bg-dark pt-[120px] pb-[110px] lg:pt-[150px] flex justify-center items-center border-none"
    >
      <div class="relative z-10 inline-block pt-11 lg:pt-0 border-none">
        <img
          src="@/assets/map2.png"
          alt="hero"
          class="max-w-full lg:ml-auto border-none"
        />
        <ul class="flex flex-wrap items-center mt-8 border-none">
          <li class="border-none">
            <a
              href="javascript:void(0)"
              class="inline-flex items-center justify-center px-6 py-3 text-base font-medium text-center text-white rounded-md bg-primary hover:bg-blue-dark lg:px-7 border-none"
            >
              안전 진단 받기
            </a>
          </li>
          <li class="ml-4 border-none">
            <a
              href="javascript:void(0)"
              class="inline-flex items-center justify-center py-3 px-5 text-center text-base font-medium text-[#464646] dark:text-white hover:text-primary border-none"
            >
              <span class="mr-2 border-none"> </span>
              지도를 통해 원하시는 지역의 시세를 확인하고, 등기부 등본 분석을
              통해 안전 진단 리포트를 제공해 드릴게요.
            </a>
          </li>
        </ul>
      </div>
    </div>
  </div>
  <!-- ====== Hero Section End -->
</template>
<style>
/* 네비게이션 바의 선 제거 */
.container,
.flex,
.header,
nav,
ul,
li,
div,
a {
  border: none !important;
}

/* 버튼 등의 추가적인 요소들에 대한 선 제거 */
button,
.block,
.py-3,
.px-7,
.px-4,
.rounded-md,
.bg-primary {
  border: none !important;
}

/* 기타 가능한 요소들에 대한 선 제거 */
.hero-content,
.clients,
.bg-white,
.bg-gray-100 {
  border: none !important;
}

/* 텍스트와 이미지의 경계에도 선 제거 */
.text-dark,
.text-body-color,
img {
  border: none !important;
}

/* 불필요한 하단의 border 관련된 다른 클래스 제거 */

.lg:px-12,
.lg:pr-0,
.rounded-md {
  border: none !important;
}
</style>
