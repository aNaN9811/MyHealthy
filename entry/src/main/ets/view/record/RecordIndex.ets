import DateUtil from '../../common/utils/DateUtil'
import RecordService from '../../service/RecordService'
import RecordVO from '../../viewmodel/RecordVO'
import RecordList from './view/RecordList'
import SearchHeader from './view/SearchHeader'
import StatsCard from './view/StatsCard'

/**
 * 记录页
 */
@Component
export default struct RecordIndex {
  @StorageProp('selectedDate')
  @Watch('initSelectedDate')
  selectedDate: number = DateUtil.beginTimeOfDay(new Date())
  @Provide records: RecordVO[] = []
  @Prop @Watch('handlePageShow') isPageShow: boolean

  aboutToAppear() {
    this.initSelectedDate()
  }

  async initSelectedDate() {
    this.records = await RecordService.queryRecordByDate(this.selectedDate)
  }

  handlePageShow() {
    if (this.isPageShow) {
      this.initSelectedDate()
    }
  }

  build() {
    Column() {
      // 1.头部搜索栏
      SearchHeader()
      // 2.统计卡片
      StatsCard()
      // 3.记录列表
      RecordList()
        .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.index_page_background'))
  }
}