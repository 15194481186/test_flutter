import 'package:enjoy_plus_hm/pages/home/detail.dart';
import 'package:enjoy_plus_hm/pages/house/building_list.dart';
import 'package:enjoy_plus_hm/pages/house/house_detail.dart';
import 'package:enjoy_plus_hm/pages/house/house_form.dart';
import 'package:enjoy_plus_hm/pages/house/house_list.dart';
import 'package:enjoy_plus_hm/pages/house/location_list.dart';
import 'package:enjoy_plus_hm/pages/house/room_list.dart';
import 'package:enjoy_plus_hm/pages/login/index.dart';
import 'package:enjoy_plus_hm/pages/profile/index.dart';
import 'package:enjoy_plus_hm/pages/tab_bar/index.dart';
import 'package:enjoy_plus_hm/stores/counter.dart';
import 'package:enjoy_plus_hm/utils/token.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (_) => CounterModel()),
      ],
      child: MaterialApp(
      routes: {
        '/': (context) => const TabBarPage(),
        '/detail': (context) => const NoticeDetail(),
        '/login': (context) => const LoginPage(),
      },
      // 获取用户跳转页面的路径

      // 如果有token, 则直接放行
      onGenerateRoute: (settings) {
        final tokenManager = TokenManager();
        final token = tokenManager.getToken() ?? '';

        // 如果没有token, 而且去的页面不是登录页跳转登录页
        if (token.isEmpty && settings.name != '/login') {
          return MaterialPageRoute(builder: (context) => const LoginPage());
        }

        // 去编辑个人信息页面
        if (settings.name == '/profile') {
          // print(settings.arguments);
          return MaterialPageRoute(
              builder: (context) =>
                  ProfilePage(userInfo: settings.arguments as Map));
        }

        // 去我的房屋列表
        if (settings.name == '/house_list') {
          return MaterialPageRoute(builder: (context) => const HouseList());
        }

        // 单元列表
        if (settings.name == '/location_list') {
          return MaterialPageRoute(builder: (context) => const LocationList());
        }

        // 楼栋列表
        if (settings.name == '/building_list') {
          return MaterialPageRoute(
              builder: (context) =>
                  BuildingList(point: (settings.arguments as Map)['point']));
        }

        // 房间列表
        if (settings.name == '/room_list') {
          Map temp = settings.arguments as Map;
          return MaterialPageRoute(
              builder: (context) =>
                  RoomList(point: temp['point'], building: temp['building']));
        }

        // 添加房屋
        if (settings.name == '/house_form') {
          return MaterialPageRoute(
              builder: (context) =>
                  HouseForm(houseInfo: settings.arguments as Map));
        }

        // 添加房屋
        if (settings.name == '/house_detail') {
          return MaterialPageRoute(
              builder: (context) =>
                  HouseDetail(houseInfo: settings.arguments as Map));
        }

        // 没有匹配到 ---> 主页面
        return MaterialPageRoute(builder: (context) => const TabBarPage());
      },
      initialRoute: '/',
    ),
    )
  );
}
