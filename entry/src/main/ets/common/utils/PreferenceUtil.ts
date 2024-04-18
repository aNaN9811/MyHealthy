import preferences from '@ohos.data.preferences';
import { CommonConstants } from '../constants/CommonConstants';
import logger from './Logger';

class PreferenceUtil {
  private pref: preferences.Preferences;

  async loadPreference(context) {
    try {
      this.pref = await preferences.getPreferences(context, CommonConstants.STORE)
      logger.debug(`加载Preferences[${CommonConstants.STORE}]成功`)
    } catch (e) {
      logger.debug(`加载Preferences[${CommonConstants.STORE}]失败`, JSON.stringify(e))
    }
  }

  async putPreferenceValue(key: string, value: preferences.ValueType) {
    if (!this.pref) {
      logger.debug(`Preferences[${CommonConstants.STORE}]尚未初始化！`)
      return
    }

    try {
      await this.pref.put(key, value)
      await this.pref.flush()
      logger.debug(`保存Preferences[${key} = ${value}]成功`)
    } catch (e) {
      logger.debug(`保存Preferences[${key} = ${value}]失败`, JSON.stringify(e))
    }
  }

  async getPreferenceValue(key: string, defaultValue: preferences.ValueType) {
    if (!this.pref) {
      logger.debug(`Preferences[${CommonConstants.STORE}]尚未初始化！`)
      return
    }

    try {
      let value = await this.pref.get(key, defaultValue)
      logger.debug(`读取Preferences[${key} = ${value}]成功`)
      return value
    } catch (e) {
      logger.debug(`读取Preferences[${key}]失败`, JSON.stringify(e))
    }
  }
}

const preferenceUtil = new PreferenceUtil()

export default preferenceUtil as PreferenceUtil