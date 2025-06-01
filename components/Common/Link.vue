<template>
  <div v-if="friendLinkList" class="friend">
    <div class="friend_link">
      <div class="link_one">友情链接:</div>
      <div v-for="(item, index) in friendLinkList" :key="index">
        <a :href="item.linkUrl" :target="item.linkTarget">{{ item.linkName }}</a>
      </div>
    </div>
  </div>
</template>
<script setup>
  import { indexApi } from '~/api/index.js'
  import { getStorage, setStorage } from '~/utils/storage.js'

  const friendLinkList = ref()
  onMounted(() => {
    friendLinkList.value = getStorage('WebsiteLink')
    if (!friendLinkList.value) {
      indexApi.websiteLink().then((res) => {
        setStorage('WebsiteLink', res, 60)
        friendLinkList.value = res
      }).catch((error) => {
        console.warn('Failed to load website links:', error)
        // 提供默认友情链接数据
        const defaultLinks = [
          { linkName: '领课网络', linkUrl: 'https://www.roncoo.com', linkTarget: '_blank' },
          { linkName: 'GitHub', linkUrl: 'https://github.com/roncoo', linkTarget: '_blank' },
          { linkName: '在线教育', linkUrl: '#', linkTarget: '_self' }
        ]
        setStorage('WebsiteLink', defaultLinks, 60)
        friendLinkList.value = defaultLinks
      })
    }
  })
</script>
<style lang="scss" scoped>
  .friend {
    clear: both;
    background-color: rgb(51, 51, 51);
    height: 30px;
    width: 100%;

    .friend_link {
      width: 1200px;
      margin: 0 auto;
      padding: 10px 0 0;

      div {
        float: left;
        font-size: 14px;

        &.link_one {
          color: #fff;
          margin-right: 20px;
        }

        a {
          color: #ccc;
          margin: 0px 10px;

          &:hover {
            color: #fff;
            text-decoration: none;
          }
        }
      }
    }
  }
</style>
