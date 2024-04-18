import common from '@ohos.app.ability.common'
import router from '@ohos.router'
import PreferenceUtil from '../common/utils/PreferenceUtil'
import UserPrivacyDialog from '../view/welcome/UserPrivacyDialog'

@Entry
@Component
struct WelcomePage {
  context = getContext(this) as common.UIAbilityContext
  controller: CustomDialogController = new CustomDialogController({
    builder: UserPrivacyDialog({
      confirm: () => this.onConfirm(),
      cancel: () => this.exitApp()
    })
  })

  aboutToAppear() {
    this.init()
  }

  private async init() {
    // 1.加载首选项
    let isAgree = await PreferenceUtil.getPreferenceValue(PREF_KEY, false)
    // 2.判断是否同意
    if (isAgree) {
      // 2.1.同意，跳转首页
      this.jumpToIndex()
    } else {
      // 2.2.不同意，弹窗
      this.controller.open()
    }
  }

  private async onConfirm() {
    // 1.保存首选项
    await PreferenceUtil.putPreferenceValue(PREF_KEY, true)
    // 2.跳转到首页
    this.jumpToIndex()
  }

  private jumpToIndex() {
    router.replaceUrl({ url: 'pages/Index' })
  }

  private exitApp() {
    // 退出APP
    this.context.terminateSelf()
  }

  build() {
    Column() {
      Image($r("app.media.welcome"))
        .objectFit(ImageFit.Cover)
    }
  }
}

const PREF_KEY = 'userPrivacyKey'