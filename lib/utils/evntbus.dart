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

