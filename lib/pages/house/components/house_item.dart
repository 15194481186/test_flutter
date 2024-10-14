import 'package:flutter/material.dart';

class HouseItem extends StatefulWidget {
  HouseItem({super.key, required this.houseInfo});

  Map houseInfo;

  @override
  State<HouseItem> createState() => _HouseItemState();
}

class _HouseItemState extends State<HouseItem> {
  Map houseInfo = {};

  @override
  void initState() {
    super.initState();
    houseInfo = widget.houseInfo;
  }

  Widget tagBuilder(int status) {
    List tagList = [
      {},
      {
        "bgColor": const Color.fromARGB(50, 91, 177, 227),
        "textColor": const Color.fromARGB(255, 85, 145, 175),
        "title": "审核中"
      },
      {
        "bgColor": const Color.fromARGB(255, 91, 243, 91),
        "textColor": const Color.fromRGBO(1, 50, 1, 1),
        "title": "审核成功"
      },
      {
        "bgColor": const Color.fromARGB(255, 247, 129, 133),
        "textColor": const Color.fromARGB(255, 84, 1, 1),
        "title": "审核失败"
      }
    ];

    return Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
        decoration: BoxDecoration(
            color: tagList[status]['bgColor'],
            borderRadius: BorderRadius.circular(5)),
        child: Text('${tagList[status]['title']}',
            style: TextStyle(color: tagList[status]['textColor'])));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Text('${houseInfo['point']}')),
                const Spacer(),
                tagBuilder(houseInfo['status'])
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Text(
                  '房间号',
                  style: TextStyle(color: Colors.grey),
                ),
                const Spacer(),
                Expanded(
                    child: Text(
                  '${houseInfo['building']}${houseInfo['room']}室',
                  textAlign: TextAlign.right,
                )),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Text(
                  '业主',
                  style: TextStyle(color: Colors.grey),
                ),
                const Spacer(),
                Expanded(
                    child: Text(
                  '${houseInfo['name']}',
                  textAlign: TextAlign.right,
                )),
              ],
            ),
          ],
        ));
  }
}
