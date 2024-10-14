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
                height: 70,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/location_list');
                    },
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [Icon(Icons.exit_to_app), Text('提交审核')],
                    )
                )
            )
          ],
        ));
  }
}
