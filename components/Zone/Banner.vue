<template>
  <div class="banner">
    <zone-category />
    <div class="carousel">
      <el-carousel height="360px">
        <el-carousel-item v-for="(item, index) in carouselList" :key="index">
          <a :href="item.carouselUrl" :title="item.carouselTitle" :target="item.carouselTarget">
            <img :src="item.carouselImg" alt="item.carouselTitle" />
          </a>
        </el-carousel-item>
      </el-carousel>
    </div>
  </div>
</template>
<script setup>
  import { indexApi } from '~/api/index.js'
  // 轮播 - 直接提供默认数据，避免SSR问题
  const carouselList = ref([
    {
      carouselTitle: '欢迎来到领课网络',
      carouselImg: 'https://via.placeholder.com/800x360/4A90E2/FFFFFF?text=欢迎来到领课网络',
      carouselUrl: '#',
      carouselTarget: '_self'
    },
    {
      carouselTitle: '在线教育平台',
      carouselImg: 'https://via.placeholder.com/800x360/50C878/FFFFFF?text=在线教育平台',
      carouselUrl: '#',
      carouselTarget: '_self'
    },
    {
      carouselTitle: '开源教育系统',
      carouselImg: 'https://via.placeholder.com/800x360/FF6B6B/FFFFFF?text=开源教育系统',
      carouselUrl: '#',
      carouselTarget: '_self'
    }
  ])
</script>
<style lang="scss" scoped>
  .banner {
    position: relative;
    width: 1200px;
    margin: 20px auto;
    display: flex;
    justify-content: space-between;
    .carousel {
      width: 100%;
      margin-left: 200px;
      img {
        width: 100%;
        height: 100%;
        border-radius: 0 10px 10px 0;
      }
    }
  }
</style>
