<template>
  <el-dialog :append-to-body="true" :model-value="props.modelValue" width="450px" center align-center :destroy-on-close="true" @close="onClose">
    <div class="wx">
      <iframe v-if="wxLoginUrl" :src="wxLoginUrl" />
    </div>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="onClose"> 取消 </el-button>
      </span>
    </template>
  </el-dialog>
</template>

<script setup>
  import { ref, watch } from 'vue'
  import { loginApi } from '~/api/login.js'
  import { indexApi } from '~/api'

  const props = defineProps({
    modelValue: {
      type: Boolean,
      default: false
    }
  })

  const emit = defineEmits(['update:modelValue', 'callback'])

  const wxLoginUrl = ref('')
  const websiteInfo = ref({})

  onMounted(() => {
    // 站点信息
    websiteInfo.value = getStorage('WebsiteInfo')
    if (!websiteInfo.value) {
      indexApi.websiteInfo().then((res) => {
        setStorage('WebsiteInfo', res, 60)
        websiteInfo.value = res
      }).catch((error) => {
        console.warn('Failed to load website info in wechat:', error)
        const defaultInfo = {
          websiteName: 'Roncoo Education',
          websiteDomain: 'https://www.roncoo.com/',
          websiteDesc: '领课网络在线教育系统'
        }
        setStorage('WebsiteInfo', defaultInfo, 60)
        websiteInfo.value = defaultInfo
      })
    }
    handleBinding()
  })

  // 获取微信授权链接
  const handleBinding = () => {
    const redirectUrl = websiteInfo.value.websiteDomain + 'account/user'
    loginApi.wxLogin({ loginAuthType: 1, redirectUrl: redirectUrl }).then((res) => {
      wxLoginUrl.value = res
    })
  }

  const onClose = () => {
    emit('update:modelValue', false)
    emit('callback')
  }
</script>

<style lang="scss" scoped>
  .wx {
    display: flex;
    justify-content: center;
    align-items: center;
    text-align: center;
    .binding-success {
      margin-top: 20px;
    }
    iframe {
      border: none;
      width: 100%;
      height: 400px;
    }
  }
</style>
