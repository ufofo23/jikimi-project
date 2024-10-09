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
            <img
              src="https://cdn.tailgrids.com/2.0/image/assets/images/logo/logo-primary.svg"
              alt="logo"
              class="dark:hidden"
            />
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
        <p
          class="mb-8 max-w-[480px] text-base text-body-color dark:text-dark-6 border-none"
        >
          등기부등본 분석을 통해 원하시는 집의 안전 점수를 확인해드릴게요! 이
          서비스를 이용한 사람이 벌써 123231278 명!
        </p>
        <ul class="flex flex-wrap items-center border-none">
          <li class="border-none">
            <a
              href="javascript:void(0)"
              class="inline-flex items-center justify-center px-6 py-3 text-base font-medium text-center text-white rounded-md bg-primary hover:bg-blue-dark lg:px-7 border-none"
            >
              바로 안전 진단 받기!
            </a>
          </li>
          <li class="ml-4 border-none">
            <a
              href="javascript:void(0)"
              class="inline-flex items-center justify-center py-3 px-5 text-center text-base font-medium text-[#464646] dark:text-white hover:text-primary border-none"
            >
              <span class="mr-2 border-none">
                <svg
                  width="24"
                  height="25"
                  viewBox="0 0 24 25"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <circle cx="12" cy="12.6152" r="12" fill="#3758F9" />
                  <rect
                    x="7.99893"
                    y="14.979"
                    width="8.18182"
                    height="1.63636"
                    fill="white"
                  />
                  <rect
                    x="11.2717"
                    y="7.61523"
                    width="1.63636"
                    height="4.09091"
                    fill="white"
                  />
                  <path
                    d="M12.0898 14.1606L14.9241 11.0925H9.25557L12.0898 14.1606Z"
                    fill="white"
                  />
                </svg>
              </span>
              Download App
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
          src="@/assets/mapp.png"
          alt="hero"
          class="max-w-full lg:ml-auto border-none"
        />
        <ul class="flex flex-wrap items-center mt-8 border-none">
          <li class="border-none">
            <a
              href="javascript:void(0)"
              class="inline-flex items-center justify-center px-6 py-3 text-base font-medium text-center text-white rounded-md bg-primary hover:bg-blue-dark lg:px-7 border-none"
            >
              실거래가 확인하기!
            </a>
          </li>
          <li class="ml-4 border-none">
            <a
              href="javascript:void(0)"
              class="inline-flex items-center justify-center py-3 px-5 text-center text-base font-medium text-[#464646] dark:text-white hover:text-primary border-none"
            >
              <span class="mr-2 border-none">
                <svg
                  width="24"
                  height="25"
                  viewBox="0 0 24 25"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <circle cx="12" cy="12.6152" r="12" fill="#3758F9" />
                  <rect
                    x="7.99893"
                    y="14.979"
                    width="8.18182"
                    height="1.63636"
                    fill="white"
                  />
                  <rect
                    x="11.2717"
                    y="7.61523"
                    width="1.63636"
                    height="4.09091"
                    fill="white"
                  />
                  <path
                    d="M12.0898 14.1606L14.9241 11.0925H9.25557L12.0898 14.1606Z"
                    fill="white"
                  />
                </svg>
              </span>
            </a>
          </li>
        </ul>
      </div>
    </div>
  </div>
  <!-- ====== Hero Section End -->
</template>
