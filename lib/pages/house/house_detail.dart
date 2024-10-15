import 'package:enjoy_plus_hm/utils/evntbus.dart';
import 'package:enjoy_plus_hm/utils/http.dart';
import 'package:enjoy_plus_hm/utils/toast.dart';
import 'package:flutter/material.dart';

class HouseDetail extends StatefulWidget {
  HouseDetail({super.key, required this.houseInfo});

  Map houseInfo;

  @override
  State<HouseDetail> createState() => _HouseDetailState();
}

class _HouseDetailState extends State<HouseDetail> {
  Map houseDetail = {};

  @override
  void initState() {
    super.initState();
    getHouseDetail(widget.houseInfo['id']);
  }

  void getHouseDetail(String id) async {
    try {
      var res = await http.get('/room/$id');
      if (res['code'] != 10000) return ToastUtil.showError(res['message']);
      setState(() {
        houseDetail = res['data'];
      });
    } catch (e) {
      ToastUtil.showError('网络请求出现问题');
    }
  }

  /// 点击删除按钮
  tapDeleteBtn(String id) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('温馨提示'),
            content: const Text('确定要删除该房屋吗？'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    '取消',
                    style: TextStyle(color: Colors.grey),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    deleteHouse(id);
                  },
                  child: const Text('确定'))
            ],
          );
        });
  }

  void deleteHouse(String id) async {
    try {
      var res = await http.delete('/room/$id');
      if (res['code'] != 10000) return ToastUtil.showError(res['message']);
      eventBus.fire(RereshHouseList());
      ToastUtil.showSuccess('删除房屋成功');
      Navigator.pop(context);
    } catch (e) {
      ToastUtil.showError('网络请求出现问题');
    }
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('房源详情'),
          centerTitle: true,
        ),
        body: houseDetail.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ListView(
                    padding: const EdgeInsets.only(bottom: 100),
                    children: [
                      // 房屋信息
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text('房屋信息',
                            style: TextStyle(
                                color: Color.fromARGB(255, 97, 94, 94),
                                fontSize: 16)),
                      ),
                      Container(
                          color: Colors.white,
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 15, bottom: 15),
                          child: Row(
                            children: [
                              Expanded(child: Text('${houseDetail['point']}')),
                              tagBuilder(1)
                            ],
                          )),
                      // 业主信息
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text('业主信息',
                            style: TextStyle(
                                color: Color.fromARGB(255, 97, 94, 94),
                                fontSize: 16)),
                      ),
                      Container(
                          color: Colors.white,
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 15, bottom: 15),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 60,
                                child: Text('房间号'),
                              ),
                              const SizedBox(width: 30),
                              Expanded(
                                  child: Text(
                                      '${houseDetail['building']}${houseDetail['room']}室'))
                            ],
                          )),
                      Container(
                          color: Colors.white,
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 15, bottom: 15),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 60,
                                child: Text('业主'),
                              ),
                              const SizedBox(width: 30),
                              Expanded(child: Text('${houseDetail['name']}'))
                            ],
                          )),
                      Container(
                          color: Colors.white,
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 15, bottom: 15),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 60,
                                child: Text('手机号'),
                              ),
                              const SizedBox(width: 30),
                              Expanded(child: Text('${houseDetail['mobile']}'))
                            ],
                          )),
                      const SizedBox(height: 30),
                      Container(
                          padding: const EdgeInsets.all(10),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('本人身份证照片'),
                              Image.network('${houseDetail['idcardFrontUrl']}',
                                  height: 200),
                              Image.network('${houseDetail['idcardBackUrl']}',
                                  height: 200)
                            ],
                          )),
                    ],
                  ),
                  Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  tapDeleteBtn(houseDetail['id']);
                                },
                                child: const Column(
                                  children: [
                                    SizedBox(
                                      height: 8,
                                      width: 120,
                                    ),
                                    Icon(Icons.delete),
                                    Text('删除房屋'),
                                    SizedBox(height: 8)
                                  ],
                                )),
                            ElevatedButton(
                                onPressed: () {},
                                child: const Column(
                                  children: [
                                    SizedBox(
                                      height: 8,
                                      width: 120,
                                    ),
                                    Icon(Icons.edit),
                                    Text('修改房屋'),
                                    SizedBox(height: 8)
                                  ],
                                ))
                          ]))
                ],
              ));
  }
}
