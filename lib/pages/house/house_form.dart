import 'package:flutter/material.dart';

class HouseForm extends StatefulWidget {
  const HouseForm({super.key});

  @override
  State<HouseForm> createState() => _HouseFormState();
}

class _HouseFormState extends State<HouseForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('添加房屋信息'),
          centerTitle: true,
        ),
        body: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            ListView(
              children: const [Text('列表')],
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: 85,
              child: ElevatedButton(
                    onPressed: () {},
                    child: const Column(
                      children: [
                        SizedBox(height: 10),
                        Icon(Icons.exit_to_app), 
                        Text('提交审核'),
                        SizedBox(height: 10), 
                      ],
                    ))
            )
          ],
        ));
  }
}
