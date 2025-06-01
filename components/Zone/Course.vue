<template>
  <div v-for="(item, index) in zoneData" :key="index" class="i_content">
    <div class="i_zone">
      <div class="zone_header">
        <div class="big_text">
          <span class="col_block" />
          {{ item.zoneName }}
          <span class="small_text">{{ item.zoneDesc }}</span>
          <nuxt-link :to="{ name: 'course-list' }" class="fr small_text link_text"> 更多课程 > </nuxt-link>
        </div>
      </div>
      <course-list :list="item.courseList" />
    </div>
  </div>
</template>
<script setup>
  import { indexApi } from '@/api/index.js'

  // 直接提供默认专区数据，避免SSR问题
  const zoneData = ref([
    {
      zoneName: '热门课程',
      zoneDesc: '精选优质课程推荐',
      courseList: [
        {
          id: 1,
          courseName: 'Vue.js 从入门到精通',
          courseImg: 'https://via.placeholder.com/300x200/42A5F5/FFFFFF?text=Vue.js课程',
          coursePrice: '¥199',
          lecturerName: '张老师'
        },
        {
          id: 2,
          courseName: 'React 实战开发',
          courseImg: 'https://via.placeholder.com/300x200/66BB6A/FFFFFF?text=React课程',
          coursePrice: '¥299',
          lecturerName: '李老师'
        }
      ]
    },
    {
      zoneName: '新课上线',
      zoneDesc: '最新发布的课程内容',
      courseList: [
        {
          id: 3,
          courseName: 'Node.js 后端开发',
          courseImg: 'https://via.placeholder.com/300x200/FFA726/FFFFFF?text=Node.js课程',
          coursePrice: '¥399',
          lecturerName: '王老师'
        },
        {
          id: 4,
          courseName: 'Python 数据分析',
          courseImg: 'https://via.placeholder.com/300x200/AB47BC/FFFFFF?text=Python课程',
          coursePrice: '¥299',
          lecturerName: '赵老师'
        }
      ]
    }
  ])
</script>
<style lang="scss" scoped>
  .i_content {
    width: 1200px;
    margin: 0 0 30px 0;
    background: #f6f8fb;
    .i_zone {
      margin-top: 30px;
      .zone_header {
        .col_block {
          display: inline-block;
          width: 4px;
          height: 24px;
          background: blue;
          position: relative;
          top: 4px;
        }
        .big_text {
          font-size: 24px;
        }
        .small_text {
          font-size: 14px;
          color: #999;
          margin-top: 10px;
        }
        .link_text:hover {
          text-decoration: none;
          color: #333;
        }
      }
    }
  }
</style>
