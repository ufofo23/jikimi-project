<template>
  <div class="about-us-container">
    <!-- Hero Section -->
    <section class="hero-section">
      <h1>You are in <span class="highlight">Charge</span></h1>
      <p>
        At [Your Company Name], we empower professionals like you to shape their
        own careers. Join us and take charge of your future.
      </p>
      <button class="cta-button">Learn More</button>
    </section>

    <!-- Expertise Section -->
    <section class="expertise-section">
      <div class="expert-card">
        <h3>Junior Legal Expert</h3>
        <button class="cta-button">Apply Now</button>
      </div>
    </section>

    <!-- Recruitment Game Section -->
    <section class="recruitment-section">
      <h2>Let's change the <span class="highlight">recruitment game</span></h2>
      <p>
        The recruitment process has been the same for too long. It's time to
        take control and make it work for you.
      </p>
      <div class="steps-container">
        <div class="step">
          <h4>You are in charge</h4>
        </div>
        <div class="step">
          <h4>It's your precious time</h4>
        </div>
        <div class="step">
          <h4>It's our job to serve you</h4>
        </div>
      </div>
    </section>

    <!-- Chat Section -->
    <section class="chat-section">
      <div class="chat-container">
        <div class="chat-content">
          <h2>Chat with <span class="highlight">[Your Company Name]</span></h2>
          <p>
            If you have any questions or need assistance, we're here to help.
            Feel free to reach out to us via chat.
          </p>
        </div>
      </div>
    </section>

    <!-- Pitch Section -->
    <section class="pitch-section">
      <h2>Listen to our <span class="highlight">pitch</span></h2>
      <p>
        We believe in transparency and open communication. Watch our pitch to
        learn more about how we can help you achieve your career goals.
      </p>
      <button class="cta-button">Watch Now</button>
    </section>
  </div>
  <Footer></Footer>
</template>

<script setup>
import Footer from '@/components/Footer.vue';
</script>

<style scoped>
.about-us-container {
  font-family: Arial, sans-serif;
}

.hero-section {
  text-align: center;
  padding: 50px;
  background-color: #f8f9fa;
}

.highlight {
  color: #ffc107;
}

.cta-button {
  background-color: #007bff;
  color: white;
  border: none;
  padding: 10px 20px;
  font-size: 16px;
  cursor: pointer;
  border-radius: 4px;
}

.expertise-section {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 50px;
  background-color: #f1f3f5;
}

.expert-card {
  text-align: center;
}

.recruitment-section {
  text-align: center;
  padding: 50px;
}

.steps-container {
  display: flex;
  justify-content: center;
  gap: 20px;
}

.step {
  text-align: center;
  max-width: 200px;
}

.chat-section {
  background-color: #e9ecef;
  padding: 50px;
  display: flex;
  justify-content: center;
}

.chat-container {
  display: flex;
  gap: 30px;
}

.chat-content {
  max-width: 400px;
}

.pitch-section {
  text-align: center;
  padding: 50px;
}
</style>
