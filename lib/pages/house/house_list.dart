import 'package:enjoy_plus_hm/pages/house/components/house_item.dart';
import 'package:enjoy_plus_hm/utils/http.dart';
import 'package:enjoy_plus_hm/utils/toast.dart';
import 'package:flutter/material.dart';

class HouseList extends StatefulWidget {
  const HouseList({super.key});

  @override
  State<HouseList> createState() => _HouseListState();
}

class _HouseListState extends State<HouseList> {
  List houseList = [];

  @override
  void initState() {
    super.initState();
    getHouseList();
  }

  /// 获取房屋列表
  void getHouseList() async {
    try {
      var res = await http.get('/room');
      if (res['code'] != 10000) return ToastUtil.showError('获取房屋列表失败');
      ToastUtil.showSuccess('获取房屋列表成功!');
      setState(() {
        houseList = res['data'];
      });
    } catch (e) {
      ToastUtil.showError('网络请求出现问题');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('我的房屋'),
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        body: houseList.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: const EdgeInsets.all(10),
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return HouseItem(houseInfo: houseList[index]);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 10,
                            color: const Color.fromARGB(255, 241, 238, 238),
                          );
                        },
                        itemCount: houseList.length),
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
                              children: [Icon(Icons.add), Text('添加房屋')],
                            )))
                  ],
                ),
              ));
  }
}
