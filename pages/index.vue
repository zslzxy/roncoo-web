<template>
  <NuxtLayout>
    <div class="main">
      <zone-banner />
      <zone-course />
    </div>
    <common-link />
  </NuxtLayout>
</template>
<script setup>
  import { indexApi } from '~/api/index'

  const { data } = await useAsyncData('website', async () => {
    // 直接返回默认数据，避免API调用失败阻止页面渲染
    return {
      websiteName: 'Roncoo Education',
      websiteDesc: '领课网络在线教育系统 - 开源教育平台',
      websiteLogo: '/logo.png',
      websiteKeywords: '在线教育,开源教育,roncoo'
    }
  })

  useHead({
    title: data.value?.websiteName || 'Roncoo Education',
    meta: [
      { hid: 'keywords', name: 'keywords', content: data.value?.websiteKeywords || '领课网络、在线教育系统、开源教育系统、roncoo-education' },
      { hid: 'description', name: 'description', content: data.value?.websiteDesc || '领课网络在线教育系统 - 开源教育平台' }
    ]
  })
</script>
<style lang="scss" scoped></style>
