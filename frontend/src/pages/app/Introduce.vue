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
            <div class="member-image-container">
              <img
                :src="member.image"
                :alt="member.name"
                class="member-image"
              />
            </div>
            <div class="member-info">
              <h3>{{ member.name }}</h3>
              <p class="member-role">{{ member.role }}</p>
              <div class="member-description">
                <div class="desc">{{ member.description }}</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
  <Footer></Footer>
</template>

<script setup>
import Footer from '@/components/Footer.vue';

const teamMembers = [
  {
    id: 1,
    name: '재성',
    role: 'Leader / BE',
    description:
      'KB "It\'s your life" 마지막 프로젝트가 성공적으로 끝났습니다. 이번 프로젝트는 서로의 강점을 잘 활용해 부족한 부분을 보완하는 과정이었으며, 각자의 경험을 바탕으로 좋은 결과를 만들어냈다고 생각합니다. 이번 경험을 통해 협업에서 중요한 것은 단순히 역할을 나누는 것이 아니라, 서로의 강점을 이해하고 보완하는 것임을 다시 한 번 깨달았습니다. 프로젝트를 함께 해주신 팀원들께 감사드립니다.',
    image: 'src/assets/members/js.png',
  },
  {
    id: 2,
    name: '지현',
    role: 'UI / FE',
    description:
      "한 달 만큼은 '나'보단 '우리'로 움직였던 시간이었던 것 같습니다. 어떤 실수든 격려해주신 팀원들 덕분에 하나의 멋진 서비스를 만들 수 있었습니다. 같은 목표를 가진 사람들과 완주를 해낸다는 것은 생각보다 더 큰 의미가 있었습니다. 각자의 부분에서 최선을 다하고, 서로의 부족함을 채워주기 위해 노력했던 시간들이 앞으로 살아가면서 큰 힘이 될 것 같습니다. ",
    image: 'src/assets/members/zh.png',
  },
  {
    id: 3,
    name: '석진',
    role: 'COO',
    description:
      '이번 팀 프로젝트를 통해 스프링 구조와 여러 개발 지식을 채우는데 도움이 되었으며 무엇보다 프로젝트 기간동안 모르는 부분들이 있을 때 팀원들의 많은 도움과 배려 덕분에  성장할 수 있게 된 계기가 되어서 뜻깊은 시간이었습니다. 그리고 개발 기간동안 많은 시간과 노력을 들여서 완벽한 마무리를 향해 달려주신 모든 팀원분들에게 매우 감사하게 생각하며 이번 프로젝트는 평생 기억에 남을 좋은 추억이 될거같습니다.',
    image: 'src/assets/members/seokjin.png',
  },
  {
    id: 4,
    name: '채영',
    role: 'UX / FE',
    description:
      '팀 프로젝트를 하면서 부족한 점이 많았지만 팀원들이 항상 도와주신 덕분에 프로젝트를 완성할 수 있었습니다. 특히 마지막에는 새벽 늦게까지 서로 도와주면서 시간을 많이 보냈던 점이 힘들기도 했지만 즐겁기도 했던 것 같아 가장 기억에 많이 남습니다. 팀원들 모두 감사합니다! (특히! 퇴근 순서 정하는 퀴즈쇼 열어주신 재성님, 새벽에 오른쪽/왼쪽이 헷갈려도 친절하게 넘어가주신 홍관님 감사합니다!)',
    image: 'src/assets/members/chaeyoung.png',
  },
  {
    id: 5,
    name: '안용',
    role: 'CTO',
    description:
      '무작정 개발을 했지만, 하나의 작품이 되는걸 보면서 쾌감을 느꼈습니다. 혼자서는 하나의 기능밖에 구현하지 못했지만 각자 맡은 일들이 모였기 때문이라 생각됩니다. 이번 프로젝틀르 통해 팀의 중요성을 다시한번 느끼게 되었습니다. 팀의 기둥인 재성님, 깃 풀 깃 푸쉬의 홍관님, 레전드 웹 디자이너 지현님, 아이디어 은행원 채영님, 그리고 발표 석진님 모두 감사합니다~',
    image: 'src/assets/members/anyong.png',
  },
  {
    id: 6,
    name: '홍관',
    role: 'COO',
    description:
      '"혼자서는 작은 한 방울이지만 함께 모이면 바다를 이룹니다."라는 말이 있습니다. 이번 팀 프로젝트를 성공적으로 완성할 수 있었던 것은 팀원들 간의 화합 덕분입니다. 각자의 역할에 충실히 임할 뿐 아니라 서로에게 상호보완하며 고생했던 팀원들에게 감사한 마음을 전합니다.',
    image: 'src/assets/members/honggwan.png',
  },
];
</script>

<style scoped>
.about-us {
  font-family: 'Arial', sans-serif;
  color: #333;
  max-width: 1200px;
  margin: 0 auto;
  padding: 4rem 2rem;
  background-color: #f9f9f9;
}

.team-section h2 {
  text-align: center;
  font-size: 2.5rem;
  margin-bottom: 4rem;
  color: #2c3e50;
}

.team-members {
  display: flex;
  flex-direction: column;
}

.team-member {
  margin-bottom: 6rem;
  width: 100%;
}

.member-content {
  display: flex;
  align-items: center;
  background-color: #ffffff;
  border-radius: 20px;
  padding: 3rem;
  max-width: 90%;
  min-height: 300px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
}

.member-content:hover {
  transform: translateY(-5px);
  box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
}

.team-member.left .member-content {
  margin-right: auto;
}

.team-member.right .member-content {
  margin-left: auto;
  flex-direction: row-reverse;
}

.member-image-container {
  flex-shrink: 0;
  width: 220px;
  height: 220px;
  border-radius: 50%;
  overflow: hidden;
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
  border: 5px solid #ffffff;
}

.member-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.team-member.left .member-image-container {
  margin-right: 3rem;
}

.team-member.right .member-image-container {
  margin-left: 3rem;
}

.member-info {
  flex: 1;
}

.member-info h3 {
  font-size: 2.2rem;
  margin-bottom: 0.5rem;
  color: #2c3e50;
}

.member-role {
  font-size: 1.2rem;
  font-weight: bold;
  color: #3498db;
  margin-bottom: 1.5rem;
  text-transform: uppercase;
}

.member-description {
  font-size: 1.1rem;
  line-height: 1.8;
  color: #34495e;
  position: relative;
  padding-left: 20px;
  border-left: 3px solid #3498db;
}

.member-description::before {
  content: '"';
  font-size: 3rem;
  color: #3498db;
  position: absolute;
  top: -20px;
  left: -15px;
  opacity: 0.3;
}

.desc {
  font-size: 22px;
}

@media (max-width: 1024px) {
  .member-content {
    flex-direction: column !important;
    text-align: center;
    max-width: 100%;
    padding: 2rem;
  }

  .member-image-container {
    margin: 0 0 2rem 0 !important;
  }

  .member-description {
    padding-left: 0;
    border-left: none;
  }

  .member-description::before {
    left: 50%;
    transform: translateX(-50%);
  }
}

@media (max-width: 768px) {
  .about-us {
    padding: 2rem 1rem;
  }

  .team-section h2 {
    font-size: 2rem;
  }

  .member-info h3 {
    font-size: 1.8rem;
  }

  .member-role {
    font-size: 1rem;
  }

  .member-description {
    font-size: 1rem;
  }
}
</style>
