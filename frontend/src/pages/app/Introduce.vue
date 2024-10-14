  
<template>
  <div class="about-us">
    <section class="team-section">
      <h2>Our Exceptional Team</h2>
      <div class="team-members">
        <div
          v-for="(member, index) in teamMembers"
          :key="member.id"
          class="team-member"
          :class="{ left: index % 2 === 0, right: index % 2 !== 0 }"
        >
          <div class="member-content">
            <img :src="member.image" :alt="member.name" class="member-image" />
            <div class="member-info">
              <h3>{{ member.name }}</h3>
              <p class="member-role">{{ member.role }}</p>
              <p class="member-description">{{ member.description }}</p>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
  <Footer></Footer>
</template>

<script setup>
import QuickChat from '@/components/QuickChat.vue';
import Footer from '@/components/Footer.vue';
const teamMembers = [
  {
    id: 1,
    name: '재성',
    role: 'Leader / BE',
    description:
      '법률 전문가로서 ASK.Q의 비전과 전략을 이끌고 있습니다. 오랜 경험을 바탕으로 고객 중심의 혁신적인 법률 서비스를 제공하기 위해 노력하고 있습니다.',
    image: 'src/assets/members/js.png',
  },
  {
    id: 2,
    name: '지현',
    role: 'UI / FE',
    description:
      '안녕하세요! 지키미의 UI 담당자입니다. 저 또한 지키미로 안전한 집에서 잘 지내고 있습니다. 여러분도 한번 이용해보세요!',
    image: 'src/assets/members/zh.png',
  },
  {
    id: 3,
    name: '석진',
    role: 'COO',
    description:
      '효율적인 운영을 통해 고객 만족도를 극대화합니다. 고객의 니즈를 정확히 파악하고, 이를 바탕으로 서비스 품질을 지속적으로 개선하는 것이 주요 목표입니다.',
    image: 'src/assets/members/seokjin.png',
  },
  {
    id: 4,
    name: '채영',
    role: 'UX / FE',
    description:
      '법률 전문가로서 ASK.Q의 비전과 전략을 이끌고 있습니다. 오랜 경험을 바탕으로 고객 중심의 혁신적인 법률 서비스를 제공하기 위해 노력하고 있습니다.',
    image: 'src/assets/members/chaeyoung.png',
  },
  {
    id: 5,
    name: '안용',
    role: 'CTO',
    description:
      '최신 기술을 활용하여 법률 서비스의 혁신을 주도합니다. AI와 빅데이터를 활용한 법률 분석 시스템 개발에 주력하고 있으며, 사용자 경험을 개선하기 위해 끊임없이 노력합니다.',
    image: 'src/assets/members/anyong.png',
  },
  {
    id: 6,
    name: '홍관',
    role: 'COO',
    description:
      '효율적인 운영을 통해 고객 만족도를 극대화합니다. 고객의 니즈를 정확히 파악하고, 이를 바탕으로 서비스 품질을 지속적으로 개선하는 것이 주요 목표입니다.',
    image: 'src/assets/members/honggwan.png',
  },
];

const features = [
  {
    id: 1,
    title: '신뢰성',
    description: '정확한 법률 정보 제공',
    icon: '/path/to/icon1.svg',
  },
  {
    id: 2,
    title: '효율성',
    description: '빠른 법률 서비스',
    icon: '/path/to/icon2.svg',
  },
  {
    id: 3,
    title: '접근성',
    description: '쉬운 법률 상담',
    icon: '/path/to/icon3.svg',
  },
];
</script>

<style scoped>
.about-us {
  font-family: 'Arial', sans-serif;
  color: #333;
  max-width: 1500px;
  margin: 0 auto;
  padding: 2rem;
}

.header {
  text-align: center;
  margin-bottom: 4rem;
  background-color: #f9f9a0;
  padding: 4rem;
  border-radius: 10px;
}

.header h1 {
  font-size: 3rem;
  margin-bottom: 1rem;
}

.cta-button,
.chat-button {
  background-color: #007bff;
  color: white;
  border: none;
  padding: 1rem 2rem;
  font-size: 1.1rem;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s;
}

.cta-button:hover,
.chat-button:hover {
  background-color: #0056b3;
}

.team-section {
  margin-bottom: 4rem;
}

.team-section h2,
.features h2,
.contact h2 {
  text-align: center;
  font-size: 2.5rem;
  margin-bottom: 3rem;
}

.team-members {
  display: flex;
  flex-direction: column;
}

.team-member {
  margin-bottom: 4rem;
  width: 100%;
}

.member-content {
  display: flex;
  align-items: center;
  background-color: #f8f8f8;
  border-radius: 15px;
  padding: 3rem;
  max-width: 75%;
  min-height: 300px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.team-member.left .member-content {
  margin-right: auto;
}

.team-member.right .member-content {
  margin-left: auto;
  flex-direction: row-reverse;
}

.member-image {
  width: 200px;
  height: 200px;
  border-radius: 50%;
  object-fit: cover;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.team-member.left .member-image {
  margin-right: 3rem;
}

.team-member.right .member-image {
  margin-left: 3rem;
}

.member-info {
  flex: 1;
}

.member-info h3 {
  font-size: 2rem;
  margin-bottom: 1rem;
}

.member-role {
  font-size: 1.2rem;
  font-weight: bold;
  color: #007bff;
  margin-bottom: 1rem;
}

.member-description {
  font-size: 1.1rem;
  line-height: 1.6;
}

.features {
  display: flex;
  justify-content: space-between;
  margin-bottom: 4rem;
}

.feature {
  flex-basis: calc(33.333% - 2rem);
  text-align: center;
}

.feature-icon {
  width: 80px;
  height: 80px;
  margin-bottom: 1.5rem;
}

.contact {
  text-align: center;
  background-color: #e6f7ff;
  padding: 4rem;
  border-radius: 15px;
}

@media (max-width: 768px) {
  .member-content {
    flex-direction: column !important;
    text-align: center;
    max-width: 100%;
    padding: 2rem;
  }

  .member-image {
    margin: 0 0 2rem 0 !important;
  }

  .feature {
    flex-basis: 100%;
    margin-bottom: 2rem;
  }
}
</style>
