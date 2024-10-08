import 'package:enjoy_plus_hm/pages/home/components/home_list.dart';
import 'package:enjoy_plus_hm/pages/home/components/home_nav.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(40, 85, 145, 175),
        appBar: AppBar(
          title: const Text('享+社区'),
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(10),
          children: [
            // 导航条
            HomeNav(),
            // 中间广告图
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset('images/banner@2x.jpg'),
            ),
            // 社区公告
            HomeList()
          ],
        ));
  }
}
