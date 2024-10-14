import 'dart:math';

import 'package:flutter/material.dart';

class RoomList extends StatefulWidget {
  RoomList({super.key, required this.point, required this.building});

  String point;
  String building;

  @override
  State<RoomList> createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  // 1. 定义初始数据
  Map data = {
    'point': '', // 小区信息
    'building': '', // 楼栋信息
    'rooms': [], // 随机产生的房间号
  };

  @override
  void initState() {
    super.initState();

    fakeData();
  }

  /// 造数据
  fakeData() {
    // 1. 随机产生房间的个数
    Random radom = Random();
    int size = radom.nextInt(6) + 3; // 3-8

    // 2. 遍历房间的个数产生房间号
    // 房间号的组成: 楼层0房间  903  1504
    List temp = [];
    for (var i = 0; i < size; i++) {
      // 2.1 随机产生楼层 1-20
      int floor = radom.nextInt(20) + 1;
      // 2.2 随机产生房间号 1-4
      int no = radom.nextInt(4) + 1;
      // 2.3 把楼层和房间号拼接
      String room = '${floor}0$no';
      // 2.5 去重
      if (temp.contains(room)) continue;
      // 2.4 把房间号添加到临时数组中
      temp.add(room);
    }

    setState(() {
      data['point'] = widget.point;
      data['building'] = widget.building;
      data['rooms'] = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('选择房间'),
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/house_form');
                },
                child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(10),
                    child: Row(children: [
                      Expanded(
                          child: Text(
                              '${data['point']}${data['building']}${data['rooms'][index]}室')),
                      const Row(children: [
                        Icon(Icons.arrow_forward_ios,
                            size: 16, color: Colors.black),
                      ])
                    ])));
          },
          itemCount: (data['rooms'] as List).length,
        ));
  }
}
