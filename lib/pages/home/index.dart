import 'package:enjoy_plus_hm/pages/home/components/home_list.dart';
import 'package:enjoy_plus_hm/pages/home/components/home_nav.dart';
import 'package:enjoy_plus_hm/utils/http.dart';
import 'package:enjoy_plus_hm/utils/toast.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List notifyList = [];

  @override
  void initState() {
    super.initState();
    getNotifyList();
  }

  /// 获取社区公告列表
  getNotifyList() async {
    try {
      final res = await http.get('/announcement');
      if(res['code'] != 10000) return ToastUtil.showError('获取数据失败');
      // print(res);
      setState(() {
        notifyList = res['data'];
      });
      ToastUtil.showSuccess('获取公告数据成功~');
    } catch (e) {
      ToastUtil.showError('网络请求错误');
    }
  }

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
              child: Image.asset('assets/images/banner@2x.jpg'),
            ),
            // 社区公告
            HomeList(notifyList: notifyList)
          ],
        ));
  }
}
