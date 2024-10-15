import 'package:event_bus/event_bus.dart';

// 1. 创建全局的eventBus实例
EventBus eventBus = EventBus();

// 2. 定义事件处理类
class LogoutEvent {
  LogoutEvent();
}

// 3. 登录成功刷新我的页面
class RefreshMineEvent {
  RefreshMineEvent();
}

// 4. 从编辑个人信息回我的页面刷新
class BackMineEvent {
  BackMineEvent();
}

// 5. 删除房屋刷新房屋列表
class RereshHouseList {
  RereshHouseList();
}
