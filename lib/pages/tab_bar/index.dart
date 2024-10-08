import 'package:enjoy_plus_hm/pages/home/index.dart';
import 'package:enjoy_plus_hm/pages/mine/index.dart';
import 'package:flutter/material.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({super.key});

  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {

 // 当前选中页面对应的索引
 int currentIndex = 0;  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          // tabBar的索引值
          index: currentIndex,
          children: const [
            HomePage(),
            MinePage()
          ],
        )
      )
    );
  }
  
  
}