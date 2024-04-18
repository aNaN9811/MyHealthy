import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import { CommonConstants } from '../common/constants/CommonConstants';
import DateUtil from '../common/utils/DateUtil';
import DbUtil from '../common/utils/DbUtil';
import preferenceUtil from '../common/utils/PreferenceUtil';
import RecordModel from '../model/RecordModel';

export default class EntryAbility extends UIAbility {
  onCreate(want, launchParam) {
    // 1.加载用户首选项
    preferenceUtil.loadPreference(this.context);
    // 2.初始化日期
    AppStorage.SetOrCreate(CommonConstants.RECORD_DATE, DateUtil.beginTimeOfDay(new Date()))
    // 3.初始化RDB工具
    this.initDb()

    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  async initDb() {
    await DbUtil.initDB(this.context)
    // 创建record表
    DbUtil.createTable(RecordModel.getCreateTableSql())
  }

  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    // // 1.获取应用主窗口。
    // let windowClass = null;
    // windowStage.getMainWindow((err, data) => {
    //   if (err.code) {
    //     console.error('Failed to obtain the main window. Cause: ' + JSON.stringify(err));
    //     return;
    //   }
    //
    //   // 2.实现沉浸式效果：设置导航栏、状态栏不显示。
    //   let names = ['status'];
    //   windowClass = data;
    //   windowClass.setWindowSystemBarEnable(names, (err) => {
    //     if (err.code) {
    //       console.error('Failed to set the system bar to be visible. Cause:' + JSON.stringify(err));
    //       return;
    //     }
    //     console.info('Succeeded in setting the system bar to be visible.');
    //   });
    // });

    windowStage.loadContent('pages/WelcomePage', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground() {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground() {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
