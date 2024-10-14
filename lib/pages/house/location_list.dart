import 'package:flutter/material.dart';

class LocationList extends StatefulWidget {
  const LocationList({super.key});

  @override
  State<LocationList> createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('选择社区'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            const Row(
              children: [
                Text(
                  '当前地址',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            const SizedBox(height: 10),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              child: const Row(
                children: [
                  Expanded(child: Text('北京市昌平区政府街19号')),
                  Row(
                    children: [
                      Icon(Icons.location_searching_outlined,
                          color: Colors.blue),
                      SizedBox(width: 2),
                      Text(
                        '重新定位',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Text(
                  '附近社区',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            const SizedBox(height: 10),
            ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(10),
                      child: const Row(children: [
                        Expanded(child: Text('北京市昌平区政府街19号')),
                        Row(children: [
                          Icon(Icons.arrow_forward_ios,
                              size: 16, color: Colors.black),
                        ])
                      ]))
                ])
          ],
        ));
  }
}
