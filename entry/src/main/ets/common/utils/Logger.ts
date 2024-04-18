import hilog from '@ohos.hilog';

const LOGGER_PREFIX: string = 'My_Healthy';

class Logger {
  private domain: number;
  private prefix: string;

  // format Indicates the log format string.
  private format: string = '%{public}s, %{public}s';

  /**
   * constructor.
   *
   * @param domain Indicates the service domain, which is a hexadecimal integer ranging from 0x0 to 0xFFFFF
   * @param prefix Identifies the log tag.
   * @param args Indicates the log parameters.
   */
  constructor(domain: number = 0xFF00, prefix: string = '') {
    this.domain = domain;
    this.prefix = prefix;
  }

  debug(...args: string[]): void {
    hilog.debug(this.domain, this.prefix, this.format, args);
  }

  info(...args: string[]): void {
    hilog.info(this.domain, this.prefix, this.format, args);
  }

  warn(...args: string[]): void {
    hilog.warn(this.domain, this.prefix, this.format, args);
  }

  error(...args: string[]): void {
    hilog.error(this.domain, this.prefix, this.format, args);
  }
}

const logger = new Logger(0xFF01, LOGGER_PREFIX)

export default logger