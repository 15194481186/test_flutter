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
    setState(() {
      data['point'] = widget.point;
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
            return Container(
                color: Colors.white,
                padding: const EdgeInsets.all(10),
                child: Row(children: [
                  Expanded(child: Text('${data['point']}4单元')),
                  const Row(children: [
                    Icon(Icons.arrow_forward_ios,
                        size: 16, color: Colors.black),
                  ])
                ]));
          },
          itemCount: 10,
        ));
  }
}
