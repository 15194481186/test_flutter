import 'package:enjoy_plus_hm/stores/counter.dart';
import 'package:enjoy_plus_hm/utils/evntbus.dart';
import 'package:enjoy_plus_hm/utils/http.dart';
import 'package:enjoy_plus_hm/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MinePage extends StatefulWidget {
  MinePage({super.key, required this.currentIndex});

  int currentIndex;

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  // 菜单数据
  final List menuList = [
    {
      "title": "我的房屋",
      "icon": "assets/images/house_profile_icon@2x.png",
    },
    {
      "title": "我的报修",
      "icon": "assets/images/repair_profile_icon@2x.png",
    },
    {
      "title": "访客记录",
      "icon": "assets/images/visitor_profile_icon@2x.png",
    }
  ];

  // 个人中心数据
  Map userInfo = {"id": "", "avatar": null, "nickName": null};

  @override
  void initState() {
    super.initState();

    eventBus.on<RefreshMineEvent>().listen((event) {
      getUserInfo();
    });

    eventBus.on<BackMineEvent>().listen((event) {
      getUserInfo();
    });
  }

  // 当widget重新构建的时候，会调用这个方法
  @override
  void didUpdateWidget(covariant MinePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex == 1) {
      // todo: 获取个人中心的数据
      getUserInfo();
    }
  }

  /// 获取个人中心数据
  void getUserInfo() async {
    try {
      var res = await http.get('/userInfo');
      if (res['code'] != 10000) return ToastUtil.showError('获取数据失败');
      // print(res['data']);
      setState(() {
        userInfo = res['data'];
      });
    } catch (e) {
      ToastUtil.showError('网络请求错误');
    }
  }

  @override
  Widget build(BuildContext context) {
    // 使用TokenModel
    final counterModel = Provider.of<CounterModel>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(200, 85, 145, 175),
      appBar: AppBar(
        title: Text('我的${counterModel.counter}',
            style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // 个人信息
          Container(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/profile',
                        arguments: userInfo);
                  },
                  child: Row(children: [
                    Row(children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: userInfo['avatar'] == null
                              ? Image.asset(
                                  'assets/images/avatar_1.jpg',
                                  width: 40,
                                  height: 40,
                                )
                              : Image.network(
                                  userInfo['avatar'],
                                  width: 40,
                                  height: 40,
                                )),
                      const SizedBox(width: 10),
                      Text('${userInfo['nickName'] ?? '默认用户'}',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white))
                    ]),
                    const Spacer(),
                    const Row(children: [
                      Text(
                        '去完善信息',
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 13,
                      )
                    ])
                  ]))),
          Container(
            padding: const EdgeInsets.all(15),
            margin:
                const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
                children: menuList.map((item) {
              return SizedBox(
                  height: 50,
                  child: GestureDetector(
                      onTap: () {
                        if (item['title'] == '我的房屋') {
                          Navigator.pushNamed(context, '/house_list');
                        }
                      },
                      child: Row(children: [
                        Row(
                          children: [
                            Image.asset(
                              item['icon'],
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              item['title'],
                              style: const TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: Colors.grey,
                        )
                      ])));
            }).toList()),
          ),

          ElevatedButton(
              onPressed: () {
                counterModel.increment();
              },
              child: const Text('修改counter'))
        ],
      ),
    );
  }
}
