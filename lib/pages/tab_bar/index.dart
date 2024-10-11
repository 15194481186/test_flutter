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

  // 底部TabBar数据
  List tabBarList = [
    {
      "title": "首页",
      "default": "assets/tabs/home_default.png",
      "active": "assets/tabs/home_active.png"
    },
    {
      "title": "我的",
      "default": "assets/tabs/my_default.png",
      "active": "assets/tabs/my_active.png"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        // tabBar的索引值
        index: currentIndex,
        children: const [HomePage(), MinePage()],
      ),
      // 底部导航条
      bottomNavigationBar: BottomNavigationBar(
          // 底部导航item的样式
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          selectedItemColor: const Color.fromARGB(255, 85, 145, 175),
          unselectedItemColor: Colors.grey,
          items: barItemList(),
          onTap: (event) {
            setState(() {
              currentIndex = event;
            });
          }),
    );
  }

  // 提供一个底部导航条的Item
  List<BottomNavigationBarItem> barItemList() {
    List<BottomNavigationBarItem> tempList = [];
    for (var item in tabBarList) {
      tempList.add(
         BottomNavigationBarItem(
            icon: Image.asset(item['default'], width: 25),
            activeIcon: Image.asset(item['active'], width: 25),
            label: item['title']
          ),
      );
    }
    return tempList;
  }
}
