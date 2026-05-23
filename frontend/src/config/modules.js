const statusOptions = {
  gender: [
    { label: '男', value: 'MALE' },
    { label: '女', value: 'FEMALE' }
  ],
  checkIn: [
    { label: '未入住', value: 'NOT_CHECKED_IN' },
    { label: '在住', value: 'LIVING' },
    { label: '已退宿', value: 'CHECKED_OUT' }
  ],
  bed: [
    { label: '可用', value: 'AVAILABLE' },
    { label: '已占用', value: 'OCCUPIED' },
    { label: '维修中', value: 'REPAIR' },
    { label: '停用', value: 'DISABLED' }
  ],
  duty: [
    { label: '待完成', value: 'PENDING' },
    { label: '已完成', value: 'FINISHED' },
    { label: '未完成', value: 'MISSED' }
  ],
  dutyType: [
    { label: '日常值日', value: 'DAILY' },
    { label: '周值日', value: 'WEEKLY' },
    { label: '大扫除', value: 'GENERAL_CLEANING' }
  ],
  bill: [
    { label: '未缴', value: 'UNPAID' },
    { label: '部分缴费', value: 'PARTIAL' },
    { label: '已缴', value: 'PAID' },
    { label: '逾期', value: 'OVERDUE' }
  ],
  repair: [
    { label: '已提交', value: 'SUBMITTED' },
    { label: '已受理', value: 'ACCEPTED' },
    { label: '处理中', value: 'PROCESSING' },
    { label: '已完成', value: 'FINISHED' },
    { label: '已取消', value: 'CANCELLED' }
  ],
  priority: [
    { label: '低', value: 'LOW' },
    { label: '普通', value: 'NORMAL' },
    { label: '高', value: 'HIGH' },
    { label: '紧急', value: 'URGENT' }
  ],
  item: [
    { label: '正常', value: 'NORMAL' },
    { label: '借出', value: 'BORROWED' },
    { label: '损坏', value: 'DAMAGED' },
    { label: '报废', value: 'SCRAPPED' }
  ],
  visit: [
    { label: '来访中', value: 'VISITING' },
    { label: '已离开', value: 'LEFT' }
  ],
  result: [
    { label: '成功', value: 'SUCCESS' },
    { label: '失败', value: 'FAIL' }
  ]
}

export const studentConfig = {
  title: '学生信息管理',
  api: '/students',
  rowKey: 'studentId',
  searchFields: ['studentNo', 'studentName', 'phone', 'college', 'major', 'className'],
  columns: [
    { prop: 'studentNo', label: '学号', width: 130 },
    { prop: 'studentName', label: '姓名', width: 100 },
    { prop: 'gender', label: '性别', width: 90, tag: true },
    { prop: 'college', label: '学院', width: 140 },
    { prop: 'major', label: '专业', width: 130 },
    { prop: 'className', label: '班级', width: 120 },
    { prop: 'phone', label: '手机号', width: 130 },
    { prop: 'checkInStatus', label: '入住状态', width: 120, tag: true }
  ],
  formFields: [
    { prop: 'studentNo', label: '学号' },
    { prop: 'studentName', label: '姓名' },
    { prop: 'gender', label: '性别', type: 'select', options: statusOptions.gender, default: 'MALE' },
    { prop: 'college', label: '学院' },
    { prop: 'major', label: '专业' },
    { prop: 'className', label: '班级' },
    { prop: 'phone', label: '手机号' },
    { prop: 'idCard', label: '身份证号' },
    { prop: 'checkInStatus', label: '入住状态', type: 'select', options: statusOptions.checkIn, default: 'NOT_CHECKED_IN' }
  ]
}

export const bedConfig = {
  title: '床位管理',
  api: '/beds',
  rowKey: 'bedId',
  searchFields: ['bedId', 'roomId', 'bedNo', 'status'],
  columns: [
    { prop: 'bedId', label: '床位ID', width: 90 },
    { prop: 'roomId', label: '房间ID', width: 90 },
    { prop: 'bedNo', label: '床位号', width: 100 },
    { prop: 'status', label: '状态', width: 120, tag: true },
    { prop: 'createdAt', label: '创建时间', width: 180 }
  ],
  formFields: [
    { prop: 'roomId', label: '房间ID', type: 'number' },
    { prop: 'bedNo', label: '床位号' },
    { prop: 'status', label: '状态', type: 'select', options: statusOptions.bed, default: 'AVAILABLE' }
  ]
}

export const dutyConfig = {
  title: '值日安排',
  api: '/duties/schedules',
  rowKey: 'scheduleId',
  searchFields: ['roomId', 'studentId', 'dutyDate', 'taskContent', 'status'],
  columns: [
    { prop: 'scheduleId', label: '安排ID', width: 90 },
    { prop: 'roomId', label: '房间ID', width: 90 },
    { prop: 'studentId', label: '学生ID', width: 90 },
    { prop: 'dutyDate', label: '值日日期', width: 120 },
    { prop: 'dutyType', label: '类型', width: 140, tag: true },
    { prop: 'taskContent', label: '任务内容', width: 220 },
    { prop: 'status', label: '状态', width: 110, tag: true }
  ],
  formFields: [
    { prop: 'roomId', label: '房间ID', type: 'number', default: 4 },
    { prop: 'studentId', label: '学生ID', type: 'number' },
    { prop: 'dutyDate', label: '值日日期', type: 'date' },
    { prop: 'dutyType', label: '值日类型', type: 'select', options: statusOptions.dutyType, default: 'DAILY' },
    { prop: 'taskContent', label: '任务内容', type: 'textarea' },
    { prop: 'status', label: '状态', type: 'select', options: statusOptions.duty, default: 'PENDING' },
    { prop: 'createdBy', label: '创建人ID', type: 'number', default: 3 }
  ]
}

export const dutyRecordConfig = {
  title: '卫生检查记录',
  api: '/duties/records',
  rowKey: 'recordId',
  searchFields: ['scheduleId', 'result', 'remark'],
  columns: [
    { prop: 'recordId', label: '记录ID', width: 90 },
    { prop: 'scheduleId', label: '安排ID', width: 90 },
    { prop: 'checkTime', label: '检查时间', width: 180 },
    { prop: 'score', label: '评分', width: 90 },
    { prop: 'result', label: '结果', width: 120, tag: true },
    { prop: 'inspectorId', label: '检查人ID', width: 110 },
    { prop: 'remark', label: '备注', width: 220 }
  ],
  formFields: [
    { prop: 'scheduleId', label: '安排ID', type: 'number' },
    { prop: 'checkTime', label: '检查时间', type: 'datetime' },
    { prop: 'score', label: '评分', type: 'number', precision: 2, default: 0 },
    { prop: 'result', label: '结果', type: 'select', options: [
      { label: '优秀', value: 'EXCELLENT' },
      { label: '良好', value: 'GOOD' },
      { label: '合格', value: 'PASS' },
      { label: '不合格', value: 'FAIL' }
    ], default: 'PASS' },
    { prop: 'inspectorId', label: '检查人ID', type: 'number', default: 2 },
    { prop: 'remark', label: '备注', type: 'textarea' }
  ]
}

export const feeTypeConfig = {
  title: '费用类型',
  api: '/fees/types',
  rowKey: 'typeId',
  searchFields: ['typeCode', 'typeName', 'billingCycle'],
  columns: [
    { prop: 'typeId', label: '类型ID', width: 90 },
    { prop: 'typeCode', label: '编码', width: 130 },
    { prop: 'typeName', label: '名称', width: 130 },
    { prop: 'billingCycle', label: '周期', width: 120 },
    { prop: 'unit', label: '单位', width: 80 },
    { prop: 'status', label: '状态', width: 90, tag: true }
  ],
  formFields: [
    { prop: 'typeCode', label: '编码' },
    { prop: 'typeName', label: '名称' },
    { prop: 'billingCycle', label: '周期', type: 'select', options: [
      { label: '月度', value: 'MONTHLY' },
      { label: '季度', value: 'QUARTERLY' },
      { label: '一次性', value: 'ONCE' }
    ], default: 'MONTHLY' },
    { prop: 'unit', label: '单位', default: '元' },
    { prop: 'status', label: '状态', type: 'number', default: 1 }
  ]
}

export const feeConfig = {
  title: '费用账单',
  api: '/fees/bills',
  rowKey: 'billId',
  searchFields: ['roomId', 'typeId', 'billMonth', 'status'],
  columns: [
    { prop: 'billId', label: '账单ID', width: 90 },
    { prop: 'roomId', label: '房间ID', width: 90 },
    { prop: 'typeId', label: '费用类型ID', width: 110 },
    { prop: 'billMonth', label: '月份', width: 110 },
    { prop: 'amount', label: '应缴金额', width: 110 },
    { prop: 'paidAmount', label: '已缴金额', width: 110 },
    { prop: 'dueDate', label: '截止日期', width: 120 },
    { prop: 'status', label: '状态', width: 110, tag: true }
  ],
  formFields: [
    { prop: 'roomId', label: '房间ID', type: 'number', default: 4 },
    { prop: 'typeId', label: '费用类型ID', type: 'number' },
    { prop: 'billMonth', label: '账单月份' },
    { prop: 'amount', label: '应缴金额', type: 'number', precision: 2, step: 1 },
    { prop: 'paidAmount', label: '已缴金额', type: 'number', precision: 2, step: 1, default: 0 },
    { prop: 'dueDate', label: '截止日期', type: 'date' },
    { prop: 'status', label: '状态', type: 'select', options: statusOptions.bill, default: 'UNPAID' },
    { prop: 'remark', label: '备注', type: 'textarea' },
    { prop: 'createdBy', label: '创建人ID', type: 'number', default: 2 }
  ]
}

export const feePaymentConfig = {
  title: '缴费记录',
  api: '/fees/payments',
  rowKey: 'paymentId',
  searchFields: ['billId', 'studentId', 'payerName', 'paymentMethod', 'transactionNo'],
  columns: [
    { prop: 'paymentId', label: '缴费ID', width: 90 },
    { prop: 'billId', label: '账单ID', width: 90 },
    { prop: 'studentId', label: '学生ID', width: 90 },
    { prop: 'payerName', label: '缴费人', width: 120 },
    { prop: 'amount', label: '金额', width: 100 },
    { prop: 'paymentTime', label: '缴费时间', width: 180 },
    { prop: 'paymentMethod', label: '方式', width: 120 },
    { prop: 'transactionNo', label: '流水号', width: 180 }
  ],
  formFields: [
    { prop: 'billId', label: '账单ID', type: 'number' },
    { prop: 'studentId', label: '学生ID', type: 'number' },
    { prop: 'payerName', label: '缴费人' },
    { prop: 'amount', label: '金额', type: 'number', precision: 2, step: 1 },
    { prop: 'paymentTime', label: '缴费时间', type: 'datetime' },
    { prop: 'paymentMethod', label: '方式', type: 'select', options: [
      { label: '现金', value: 'CASH' },
      { label: '微信', value: 'WECHAT' },
      { label: '支付宝', value: 'ALIPAY' },
      { label: '银行卡', value: 'BANK_CARD' }
    ], default: 'WECHAT' },
    { prop: 'transactionNo', label: '流水号' },
    { prop: 'createdBy', label: '登记人ID', type: 'number', default: 2 }
  ]
}

export const repairConfig = {
  title: '维修报修单',
  api: '/repairs/orders',
  rowKey: 'orderId',
  searchFields: ['repairTitle', 'locationDesc', 'priority', 'status'],
  columns: [
    { prop: 'orderId', label: '维修单ID', width: 100 },
    { prop: 'roomId', label: '房间ID', width: 90 },
    { prop: 'reporterStudentId', label: '报修学生ID', width: 120 },
    { prop: 'repairTitle', label: '标题', width: 180 },
    { prop: 'locationDesc', label: '位置', width: 150 },
    { prop: 'priority', label: '优先级', width: 100, tag: true },
    { prop: 'status', label: '状态', width: 120, tag: true },
    { prop: 'reportTime', label: '报修时间', width: 180 }
  ],
  formFields: [
    { prop: 'roomId', label: '房间ID', type: 'number', default: 4 },
    { prop: 'reporterStudentId', label: '报修学生ID', type: 'number' },
    { prop: 'repairTitle', label: '维修标题' },
    { prop: 'repairContent', label: '维修内容', type: 'textarea' },
    { prop: 'locationDesc', label: '位置描述' },
    { prop: 'priority', label: '优先级', type: 'select', options: statusOptions.priority, default: 'NORMAL' },
    { prop: 'status', label: '状态', type: 'select', options: statusOptions.repair, default: 'SUBMITTED' },
    { prop: 'handlerAdminId', label: '处理人ID', type: 'number' }
  ]
}

export const repairProcessConfig = {
  title: '维修处理记录',
  api: '/repairs/processes',
  rowKey: 'processId',
  searchFields: ['orderId', 'oldStatus', 'newStatus', 'processContent'],
  columns: [
    { prop: 'processId', label: '处理ID', width: 90 },
    { prop: 'orderId', label: '维修单ID', width: 100 },
    { prop: 'operatorAdminId', label: '操作人ID', width: 110 },
    { prop: 'oldStatus', label: '原状态', width: 120 },
    { prop: 'newStatus', label: '新状态', width: 120, tag: true },
    { prop: 'processContent', label: '处理内容', width: 260 },
    { prop: 'processTime', label: '处理时间', width: 180 }
  ],
  formFields: [
    { prop: 'orderId', label: '维修单ID', type: 'number' },
    { prop: 'operatorAdminId', label: '操作人ID', type: 'number', default: 2 },
    { prop: 'oldStatus', label: '原状态' },
    { prop: 'newStatus', label: '新状态', type: 'select', options: statusOptions.repair, default: 'PROCESSING' },
    { prop: 'processContent', label: '处理内容', type: 'textarea' },
    { prop: 'processTime', label: '处理时间', type: 'datetime' }
  ]
}

export const itemConfig = {
  title: '宿舍物品',
  api: '/items',
  rowKey: 'itemId',
  searchFields: ['itemCode', 'itemName', 'category', 'itemStatus'],
  columns: [
    { prop: 'itemCode', label: '物品编码', width: 140 },
    { prop: 'itemName', label: '物品名称', width: 130 },
    { prop: 'category', label: '分类', width: 120 },
    { prop: 'quantity', label: '数量', width: 80 },
    { prop: 'unit', label: '单位', width: 80 },
    { prop: 'roomId', label: '房间ID', width: 90 },
    { prop: 'itemStatus', label: '状态', width: 110, tag: true },
    { prop: 'keeperStudentId', label: '保管学生ID', width: 120 }
  ],
  formFields: [
    { prop: 'roomId', label: '房间ID', type: 'number', default: 4 },
    { prop: 'itemCode', label: '物品编码' },
    { prop: 'itemName', label: '物品名称' },
    { prop: 'category', label: '分类' },
    { prop: 'quantity', label: '数量', type: 'number', default: 1 },
    { prop: 'unit', label: '单位', default: '件' },
    { prop: 'purchaseDate', label: '购入日期', type: 'date' },
    { prop: 'itemStatus', label: '状态', type: 'select', options: statusOptions.item, default: 'NORMAL' },
    { prop: 'keeperStudentId', label: '保管学生ID', type: 'number' },
    { prop: 'remark', label: '备注', type: 'textarea' }
  ]
}

export const itemBorrowConfig = {
  title: '物品借用',
  api: '/items/borrows',
  rowKey: 'borrowId',
  searchFields: ['itemId', 'borrowerStudentId', 'status', 'remark'],
  columns: [
    { prop: 'borrowId', label: '借用ID', width: 90 },
    { prop: 'itemId', label: '物品ID', width: 90 },
    { prop: 'borrowerStudentId', label: '借用学生ID', width: 120 },
    { prop: 'borrowTime', label: '借用时间', width: 180 },
    { prop: 'expectedReturnTime', label: '预计归还', width: 180 },
    { prop: 'actualReturnTime', label: '实际归还', width: 180 },
    { prop: 'status', label: '状态', width: 110, tag: true }
  ],
  formFields: [
    { prop: 'itemId', label: '物品ID', type: 'number' },
    { prop: 'borrowerStudentId', label: '借用学生ID', type: 'number' },
    { prop: 'borrowTime', label: '借用时间', type: 'datetime' },
    { prop: 'expectedReturnTime', label: '预计归还', type: 'datetime' },
    { prop: 'actualReturnTime', label: '实际归还', type: 'datetime' },
    { prop: 'status', label: '状态', type: 'select', options: [
      { label: '借用中', value: 'BORROWING' },
      { label: '已归还', value: 'RETURNED' },
      { label: '逾期', value: 'OVERDUE' }
    ], default: 'BORROWING' },
    { prop: 'remark', label: '备注', type: 'textarea' }
  ]
}

export const visitorConfig = {
  title: '访客信息',
  api: '/visitors',
  rowKey: 'visitorId',
  searchFields: ['visitorName', 'phone', 'relationship'],
  columns: [
    { prop: 'visitorId', label: '访客ID', width: 90 },
    { prop: 'visitorName', label: '姓名', width: 120 },
    { prop: 'phone', label: '手机号', width: 140 },
    { prop: 'idCard', label: '证件号', width: 180 },
    { prop: 'relationship', label: '关系', width: 140 },
    { prop: 'createdAt', label: '创建时间', width: 180 }
  ],
  formFields: [
    { prop: 'visitorName', label: '姓名' },
    { prop: 'phone', label: '手机号' },
    { prop: 'idCard', label: '证件号' },
    { prop: 'relationship', label: '关系' }
  ]
}

export const visitConfig = {
  title: '来访记录',
  api: '/visits',
  rowKey: 'visitId',
  searchFields: ['visitorId', 'studentId', 'visitReason', 'status'],
  columns: [
    { prop: 'visitId', label: '来访ID', width: 90 },
    { prop: 'visitorId', label: '访客ID', width: 90 },
    { prop: 'studentId', label: '被访学生ID', width: 120 },
    { prop: 'roomId', label: '房间ID', width: 90 },
    { prop: 'visitReason', label: '来访原因', width: 220 },
    { prop: 'visitTime', label: '来访时间', width: 180 },
    { prop: 'leaveTime', label: '离开时间', width: 180 },
    { prop: 'status', label: '状态', width: 110, tag: true }
  ],
  formFields: [
    { prop: 'visitorId', label: '访客ID', type: 'number' },
    { prop: 'studentId', label: '被访学生ID', type: 'number' },
    { prop: 'roomId', label: '房间ID', type: 'number', default: 4 },
    { prop: 'visitReason', label: '来访原因', type: 'textarea' },
    { prop: 'visitTime', label: '来访时间', type: 'datetime' },
    { prop: 'leaveTime', label: '离开时间', type: 'datetime' },
    { prop: 'status', label: '状态', type: 'select', options: statusOptions.visit, default: 'VISITING' },
    { prop: 'registerAdminId', label: '登记人ID', type: 'number', default: 2 }
  ]
}

export const logConfig = {
  title: '操作日志管理',
  api: '/logs',
  rowKey: 'logId',
  searchFields: ['moduleName', 'operationType', 'operationDesc', 'resultStatus'],
  columns: [
    { prop: 'logId', label: '日志ID', width: 90 },
    { prop: 'adminId', label: '管理员ID', width: 100 },
    { prop: 'moduleName', label: '模块', width: 130 },
    { prop: 'operationType', label: '操作类型', width: 120 },
    { prop: 'operationDesc', label: '操作描述', width: 260 },
    { prop: 'requestIp', label: '请求IP', width: 130 },
    { prop: 'operationTime', label: '操作时间', width: 180 },
    { prop: 'resultStatus', label: '结果', width: 100, tag: true }
  ],
  formFields: [
    { prop: 'adminId', label: '管理员ID', type: 'number' },
    { prop: 'moduleName', label: '模块' },
    { prop: 'operationType', label: '操作类型' },
    { prop: 'operationDesc', label: '操作描述', type: 'textarea' },
    { prop: 'requestIp', label: '请求IP', default: '127.0.0.1' },
    { prop: 'operationTime', label: '操作时间', type: 'datetime' },
    { prop: 'resultStatus', label: '结果', type: 'select', options: statusOptions.result, default: 'SUCCESS' }
  ]
}
