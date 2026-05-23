import axios from 'axios'
import { ElMessage } from 'element-plus'
import { demoRequest, isDemoMode } from './demoData'

const http = axios.create({
  baseURL: import.meta.env.VITE_API_BASE_URL || '/api',
  timeout: 10000
})

http.interceptors.response.use(
  (response) => {
    const body = response.data
    if (body && body.code && body.code !== 200) {
      ElMessage.error(body.message || '请求失败')
      return Promise.reject(new Error(body.message || '请求失败'))
    }
    return body?.data ?? body
  },
  (error) => Promise.reject(error)
)

let demoNoticeShown = false

function shouldUseDemoFallback(error) {
  return isDemoMode() && (!error.response || error.response.status === 404 || error.response.status >= 500)
}

async function call(method, url, data) {
  try {
    return await http.request({ method, url, data })
  } catch (error) {
    if (shouldUseDemoFallback(error)) {
      if (!demoNoticeShown) {
        demoNoticeShown = true
        ElMessage.warning('当前为 GitHub Pages 演示模式，数据来自前端示例数据。')
      }
      return demoRequest(method, url, data)
    }
    ElMessage.error(error.response?.data?.message || error.message || '网络异常')
    return Promise.reject(error)
  }
}

const request = {
  get(url) {
    return call('get', url)
  },
  post(url, data) {
    return call('post', url, data)
  },
  put(url, data) {
    return call('put', url, data)
  },
  delete(url) {
    return call('delete', url)
  }
}

export default request
