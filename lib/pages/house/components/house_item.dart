import 'package:flutter/material.dart';

class HouseItem extends StatefulWidget {
  const HouseItem({super.key});

  @override
  State<HouseItem> createState() => _HouseItemState();
}

class _HouseItemState extends State<HouseItem> {
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
        child:  Text('${tagList[status]['title']}',
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
                const Expanded(child: Text('仙基公寓')),
                const Spacer(),
                tagBuilder(3)
              ],
            ),
            const SizedBox(height: 15),
            const Row(
              children: [
                Text(
                  '房间号',
                  style: TextStyle(color: Colors.grey),
                ),
                Spacer(),
                Expanded(
                    child: Text(
                  '1栋2003室',
                  textAlign: TextAlign.right,
                )),
              ],
            ),
            const SizedBox(height: 15),
            const Row(
              children: [
                Text(
                  '业主',
                  style: TextStyle(color: Colors.grey),
                ),
                Spacer(),
                Expanded(
                    child: Text(
                  '张继科',
                  textAlign: TextAlign.right,
                )),
              ],
            ),
          ],
        ));
  }
}
