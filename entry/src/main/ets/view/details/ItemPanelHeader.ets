import { CommonConstants } from '../../common/constants/CommonConstants'
import DateUtil from '../../common/utils/DateUtil'

@Component
export default struct ItemPanelHeader {
  @StorageProp('selectedDate') selectedDate: number = DateUtil.beginTimeOfDay(new Date())

  build() {
    Row() {
      Text(DateUtil.formatDate(this.selectedDate))
        .fontSize(18).fontWeight(CommonConstants.FONT_WEIGHT_600)
    }
  }
}