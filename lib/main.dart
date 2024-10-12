import 'package:enjoy_plus_hm/pages/home/detail.dart';
import 'package:enjoy_plus_hm/pages/login/index.dart';
import 'package:enjoy_plus_hm/pages/profile/index.dart';
import 'package:enjoy_plus_hm/pages/tab_bar/index.dart';
import 'package:enjoy_plus_hm/utils/token.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
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
        if(token.isEmpty && settings.name != '/login'){
          return MaterialPageRoute(builder: (context) => const LoginPage());
        }
        
        // 去编辑个人信息页面
        if(settings.name == '/profile'){
          return MaterialPageRoute(builder: (context) => const ProfilePage());
        }
        
        // 404页面
        return null;
      },
      initialRoute: '/',
    ),
  );
}
