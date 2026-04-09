import request from '@/utils/request'



// 通用上传工具类
export function upload( file) {
  const formData = new FormData()
  formData.append('file', file)
  return request({
    url: '/common/upload',
    method: 'post',
    data: formData,
    headers: {
      'Content-Type': 'multipart/form-data'
    }
  })
}
