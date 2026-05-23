import { createRouter, createWebHashHistory } from 'vue-router'
import AdminLayout from '../layout/AdminLayout.vue'
import Login from '../views/Login.vue'
import Dashboard from '../views/Dashboard.vue'
import StudentManage from '../views/StudentManage.vue'
import BedManage from '../views/BedManage.vue'
import DutyManage from '../views/DutyManage.vue'
import FeeManage from '../views/FeeManage.vue'
import RepairManage from '../views/RepairManage.vue'
import ItemManage from '../views/ItemManage.vue'
import VisitManage from '../views/VisitManage.vue'
import OperationLogManage from '../views/OperationLogManage.vue'

const routes = [
  { path: '/login', component: Login },
  {
    path: '/',
    component: AdminLayout,
    redirect: '/dashboard',
    children: [
      { path: 'dashboard', component: Dashboard, meta: { title: '首页数据看板' } },
      { path: 'students', component: StudentManage, meta: { title: '学生信息管理' } },
      { path: 'beds', component: BedManage, meta: { title: '床位管理' } },
      { path: 'duties', component: DutyManage, meta: { title: '卫生值日管理' } },
      { path: 'fees', component: FeeManage, meta: { title: '费用管理' } },
      { path: 'repairs', component: RepairManage, meta: { title: '维修报修管理' } },
      { path: 'items', component: ItemManage, meta: { title: '宿舍物品管理' } },
      { path: 'visits', component: VisitManage, meta: { title: '来访登记管理' } },
      { path: 'logs', component: OperationLogManage, meta: { title: '操作日志管理' } }
    ]
  }
]

const router = createRouter({
  history: createWebHashHistory(import.meta.env.BASE_URL),
  routes
})

router.beforeEach((to) => {
  if (to.path !== '/login' && localStorage.getItem('dormitoryLogin') !== '1') {
    return '/login'
  }
  return true
})

export default router
