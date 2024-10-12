import 'package:enjoy_plus_hm/pages/house/components/house_item.dart';
import 'package:flutter/material.dart';

class HouseList extends StatefulWidget {
  const HouseList({super.key});

  @override
  State<HouseList> createState() => _HouseListState();
}

class _HouseListState extends State<HouseList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的房屋'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return const HouseItem();
                },
                separatorBuilder: (BuildContext context, int index) {
                   return Container(
                    height: 10,
                    color: const Color.fromARGB(255, 241, 238, 238),
                  );
                },
                itemCount: 5),
            Container(
                padding: const EdgeInsets.all(10),
                height: 70,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () {},
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [Icon(Icons.add), Text('添加房屋')],
                    )))
          ],
        ),
      ),
    );
  }
}
