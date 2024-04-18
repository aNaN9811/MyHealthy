import BreakpointType from '../common/bean/BreanpointType'
import BreakpointConstants from '../common/constants/BreakpointConstants'
import { CommonConstants } from '../common/constants/CommonConstants'
import BreakpointSystem from '../common/utils/BreakpointSystem'
import RecordIndex from '../view/record/RecordIndex'

/**
 * 主布局
 */
@Entry
@Component
struct Index {
  @State currentIndex: number = 0
  private breakpointSystem: BreakpointSystem = new BreakpointSystem()
  @StorageProp('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_SM
  @State isPageShow: boolean = false

  aboutToAppear() {
    this.breakpointSystem.register()
  }

  onPageShow(){
    this.isPageShow = true
  }
  onPageHide(){
    this.isPageShow = false
  }

  aboutToDisappear() {
    this.breakpointSystem.unregister();
  }

  build() {
    Tabs({ barPosition: BreakpointConstants.BAR_POSITION.getValue(this.currentBreakpoint) }) {
      TabContent() {
        RecordIndex({isPageShow: this.isPageShow})
      }
      .tabBar(this.TabBarBuilder($r('app.string.tab_record'), $r('app.media.ic_calendar'), 0))

      TabContent() {
        Text('发现页面')
      }
      .tabBar(this.TabBarBuilder($r('app.string.tab_discover'), $r('app.media.discover'), 1))

      TabContent() {
        Text('我的主页')
      }
      .tabBar(this.TabBarBuilder($r('app.string.tab_user'), $r('app.media.ic_user_portrait'), 2))

    }
    .width('100%')
    .height('100%')
    .onChange(index => this.currentIndex = index)
    .vertical(new BreakpointType({
      sm: false,
      md: true,
      lg: true
    }).getValue(this.currentBreakpoint))
  }

  @Builder TabBarBuilder(title: ResourceStr, image: ResourceStr, index: number) {
    Column({ space: CommonConstants.SPACE_8 }) {
      Image(image)
        .width(22)
        .fillColor(this.selectColor(index))
      Text(title)
        .fontSize(14)
        .fontColor(this.selectColor(index))
    }
  }

  private selectColor(index: number) {
    return this.currentIndex === index ? $r('app.color.primary_color') : $r('app.color.gray')
  }
}