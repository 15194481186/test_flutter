import 'dart:math';

import 'package:flutter/material.dart';

class BuildingList extends StatefulWidget {
  BuildingList({super.key, required this.point});

  // 接收小区信息
  String point;

  @override
  State<BuildingList> createState() => _RoomListState();
}

class _RoomListState extends State<BuildingList> {
  Map data = {
    "point": "", // 记录小区信息
    "size": 0, // 随机产生楼栋的数量
    "type": "", // 小区的楼栋名称(size>4 单元, size<=4 号楼)
  };

  @override
  void initState() {
    super.initState();
    fakeData();
  }

  // 随机产出3-8条数据
  // 如果数据<5, 则显示单元
  // 如果数据>=5, 则显示楼栋
  void fakeData() {
    // 1. 产生随机数
    Random random = Random();
    int size = random.nextInt(6) + 3;
    // 2. 单元和楼栋
    String type = size < 5 ? '单元' : '号楼';
    // 3. 更新
    setState(() {
      data['point'] = widget.point;
      data['size'] = size;
      data['type'] = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('选择楼栋'),
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () {
                  // 1. 跳转页面
                  Navigator.pushNamed(context, '/room_list', arguments: {
                    'point': data['point'],
                    'building': '${index+1}${data['type']}'
                  });
                },
                child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(10),
                    child: Row(children: [
                      Expanded(
                          child: Text(
                              '${data['point']}${index + 1}${data['type']}')),
                      const Row(children: [
                        Icon(Icons.arrow_forward_ios,
                            size: 16, color: Colors.black),
                      ])
                    ])));
          },
          itemCount: data['size'],
        ));
  }
}
