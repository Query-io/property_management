/**
 * @classdesc 字典数据
 * @property.js {String} label 标签
 * @property.js {*} value 标签
 * @property.js {Object} raw 原始数据
 */
export default class DictData {
  constructor(label, value, raw) {
    this.label = label
    this.value = value
    this.raw = raw
  }
}
