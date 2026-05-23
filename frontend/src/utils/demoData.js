const storeKey = 'dormitoryDemoStore'

const dashboard = {
  overview: {
    studentCount: 4,
    roomCount: 1,
    bedCount: 4,
    occupiedBedCount: 4,
    unpaidBillCount: 2,
    pendingRepairCount: 1,
    todayVisitCount: 1
  },
  roomOccupancy: [{ roomNo: '504', occupancyRate: 100 }],
  repairStatus: [
    { status: 'SUBMITTED', count: 1 },
    { status: 'PROCESSING', count: 1 },
    { status: 'FINISHED', count: 2 }
  ],
  feeMonthly: [
    { typeName: '水费', totalAmount: 86.5, paidAmount: 42.5 },
    { typeName: '电费', totalAmount: 168.8, paidAmount: 120 },
    { typeName: '网费', totalAmount: 80, paidAmount: 80 }
  ]
}

const initialStore = {
  '/students': [
    { studentId: 1, studentNo: '2341103319', studentName: '索南', gender: 'MALE', college: '信息工程学院', major: '计算机科学与技术', className: '计科2301', phone: '13800000001', idCard: '540100200401010019', checkInStatus: 'LIVING' },
    { studentId: 2, studentNo: '2341103320', studentName: '王一凡', gender: 'MALE', college: '信息工程学院', major: '软件工程', className: '软工2301', phone: '13800000002', idCard: '110100200402020020', checkInStatus: 'LIVING' },
    { studentId: 3, studentNo: '2341103321', studentName: '李明', gender: 'MALE', college: '信息工程学院', major: '数据科学', className: '数科2301', phone: '13800000003', idCard: '110100200403030030', checkInStatus: 'LIVING' },
    { studentId: 4, studentNo: '2341103322', studentName: '张强', gender: 'MALE', college: '信息工程学院', major: '网络工程', className: '网工2301', phone: '13800000004', idCard: '110100200404040040', checkInStatus: 'LIVING' }
  ],
  '/beds': [
    { bedId: 1, roomId: 4, bedNo: '1号床', status: 'OCCUPIED', createdAt: '2026-03-01 08:00:00' },
    { bedId: 2, roomId: 4, bedNo: '2号床', status: 'OCCUPIED', createdAt: '2026-03-01 08:00:00' },
    { bedId: 3, roomId: 4, bedNo: '3号床', status: 'OCCUPIED', createdAt: '2026-03-01 08:00:00' },
    { bedId: 4, roomId: 4, bedNo: '4号床', status: 'OCCUPIED', createdAt: '2026-03-01 08:00:00' }
  ],
  '/duties/schedules': [
    { scheduleId: 1, roomId: 4, studentId: 1, dutyDate: '2026-05-23', dutyType: 'DAILY', taskContent: '扫地、拖地、整理阳台', status: 'FINISHED', createdBy: 3 },
    { scheduleId: 2, roomId: 4, studentId: 2, dutyDate: '2026-05-24', dutyType: 'DAILY', taskContent: '倒垃圾、擦桌面', status: 'PENDING', createdBy: 3 }
  ],
  '/duties/records': [
    { recordId: 1, scheduleId: 1, checkTime: '2026-05-23T20:30:00', score: 96, result: 'EXCELLENT', inspectorId: 2, remark: '地面干净，物品摆放整齐' }
  ],
  '/fees/types': [
    { typeId: 1, typeCode: 'WATER', typeName: '水费', billingCycle: 'MONTHLY', unit: '元', status: 1 },
    { typeId: 2, typeCode: 'ELECTRIC', typeName: '电费', billingCycle: 'MONTHLY', unit: '元', status: 1 },
    { typeId: 3, typeCode: 'NET', typeName: '网费', billingCycle: 'MONTHLY', unit: '元', status: 1 }
  ],
  '/fees/bills': [
    { billId: 1, roomId: 4, typeId: 1, billMonth: '2026-05', amount: 86.5, paidAmount: 42.5, dueDate: '2026-05-30', status: 'PARTIAL', remark: '504宿舍五月水费', createdBy: 2 },
    { billId: 2, roomId: 4, typeId: 2, billMonth: '2026-05', amount: 168.8, paidAmount: 120, dueDate: '2026-05-30', status: 'PARTIAL', remark: '504宿舍五月电费', createdBy: 2 },
    { billId: 3, roomId: 4, typeId: 3, billMonth: '2026-05', amount: 80, paidAmount: 80, dueDate: '2026-05-30', status: 'PAID', remark: '504宿舍五月网费', createdBy: 2 }
  ],
  '/fees/payments': [
    { paymentId: 1, billId: 1, studentId: 1, payerName: '索南', amount: 42.5, paymentTime: '2026-05-20T19:20:00', paymentMethod: 'WECHAT', transactionNo: 'WX202605200001', createdBy: 2 }
  ],
  '/repairs/orders': [
    { orderId: 1, roomId: 4, reporterStudentId: 1, repairTitle: '空调遥控器失灵', repairContent: '空调遥控器按键无反应', locationDesc: '南区11栋504', priority: 'NORMAL', status: 'PROCESSING', handlerAdminId: 2, reportTime: '2026-05-21T10:00:00' },
    { orderId: 2, roomId: 4, reporterStudentId: 3, repairTitle: '阳台灯闪烁', repairContent: '阳台顶灯夜间闪烁', locationDesc: '504阳台', priority: 'HIGH', status: 'SUBMITTED', handlerAdminId: 2, reportTime: '2026-05-23T09:10:00' }
  ],
  '/repairs/processes': [
    { processId: 1, orderId: 1, operatorAdminId: 2, oldStatus: 'SUBMITTED', newStatus: 'PROCESSING', processContent: '已联系维修师傅上门检查', processTime: '2026-05-21T14:30:00' }
  ],
  '/items': [
    { itemId: 1, roomId: 4, itemCode: '504-AIR-01', itemName: '空调', category: '电器', quantity: 1, unit: '台', purchaseDate: '2024-09-01', itemStatus: 'NORMAL', keeperStudentId: 1, remark: '宿舍公共物品' },
    { itemId: 2, roomId: 4, itemCode: '504-DESK-01', itemName: '书桌', category: '家具', quantity: 4, unit: '张', purchaseDate: '2024-09-01', itemStatus: 'NORMAL', keeperStudentId: 2, remark: '每人一张' }
  ],
  '/items/borrows': [
    { borrowId: 1, itemId: 2, borrowerStudentId: 3, borrowTime: '2026-05-22T18:00:00', expectedReturnTime: '2026-05-24T18:00:00', actualReturnTime: null, status: 'BORROWING', remark: '临时借用折叠桌' }
  ],
  '/visitors': [
    { visitorId: 1, visitorName: '索南父亲', phone: '13900000001', idCard: '540100197001010011', relationship: '家长', createdAt: '2026-05-23 09:00:00' }
  ],
  '/visits': [
    { visitId: 1, visitorId: 1, studentId: 1, roomId: 4, visitReason: '探望学生并送生活用品', visitTime: '2026-05-23T10:00:00', leaveTime: null, status: 'VISITING', registerAdminId: 2 }
  ],
  '/logs': [
    { logId: 1, adminId: 1, moduleName: '学生管理', operationType: 'QUERY', operationDesc: '查询南区11栋504学生信息', requestIp: '127.0.0.1', operationTime: '2026-05-23T09:30:00', resultStatus: 'SUCCESS' }
  ]
}

const idKeys = {
  '/students': 'studentId',
  '/beds': 'bedId',
  '/duties/schedules': 'scheduleId',
  '/duties/records': 'recordId',
  '/fees/types': 'typeId',
  '/fees/bills': 'billId',
  '/fees/payments': 'paymentId',
  '/repairs/orders': 'orderId',
  '/repairs/processes': 'processId',
  '/items': 'itemId',
  '/items/borrows': 'borrowId',
  '/visitors': 'visitorId',
  '/visits': 'visitId',
  '/logs': 'logId'
}

export function isDemoMode() {
  return window.location.hostname.endsWith('github.io') && !import.meta.env.VITE_API_BASE_URL
}

function clone(value) {
  return JSON.parse(JSON.stringify(value))
}

function loadStore() {
  const raw = localStorage.getItem(storeKey)
  if (!raw) return clone(initialStore)
  try {
    return { ...clone(initialStore), ...JSON.parse(raw) }
  } catch {
    return clone(initialStore)
  }
}

function saveStore(store) {
  localStorage.setItem(storeKey, JSON.stringify(store))
}

function normalize(url) {
  return url.replace(/\/list$/, '').replace(/\/details$/, '')
}

function nextId(rows, idKey) {
  return rows.reduce((max, row) => Math.max(max, Number(row[idKey]) || 0), 0) + 1
}

export function demoRequest(method, url, data) {
  if (method === 'get' && url === '/dashboard') return clone(dashboard)
  if (method === 'get' && url === '/beds/details') return clone(loadStore()['/beds'])

  const store = loadStore()
  const base = normalize(url)
  const idMatch = url.match(/\/(\d+)$/)
  const id = idMatch ? Number(idMatch[1]) : null
  const rows = store[base] || []
  const idKey = idKeys[base]

  if (method === 'get') {
    if (id && idKey) return clone(rows.find((row) => Number(row[idKey]) === id) || null)
    return clone(rows)
  }

  if (method === 'post') {
    const row = { ...data, [idKey]: nextId(rows, idKey) }
    store[base] = [row, ...rows]
    saveStore(store)
    return clone(row)
  }

  if (method === 'put') {
    store[base] = rows.map((row) => (Number(row[idKey]) === id ? { ...row, ...data, [idKey]: id } : row))
    saveStore(store)
    return true
  }

  if (method === 'delete') {
    store[base] = rows.filter((row) => Number(row[idKey]) !== id)
    saveStore(store)
    return true
  }

  return null
}
