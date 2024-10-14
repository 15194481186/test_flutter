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
    'rooms': ['102', '203', '1203'], // 随机产生的房间号
  };

  @override
  void initState() {
    super.initState();

    setState(() {
      data['point'] = widget.point;
      data['building'] = widget.building;
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
            return Container(
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
                ]));
          },
          itemCount: (data['rooms'] as List).length,
        ));
  }
}
