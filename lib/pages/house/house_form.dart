import 'package:flutter/material.dart';

class HouseForm extends StatefulWidget {
  const HouseForm({super.key});

  @override
  State<HouseForm> createState() => _HouseFormState();
}

class _HouseFormState extends State<HouseForm> {
   final Map _formData = {
    'point': '', // 小区信息
    'building': '', // 小区楼栋信息
    'room': '', // 小区房间信息
    'name': '', // 业主姓名
    'gender': 1, // 业主性别0女1男
    'mobile': '', // 业主电话
    'idcardFrontUrl': 'assets/images/idcard1.png', // 身份证正面
    'idcardBackUrl': 'assets/images/idcard2.png', // 身份证背面
  };
  
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
              padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                  child: const Text('仙基公寓4单元 1602'),
                ),
                // 业主信息
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text('业主信息',
                      style: TextStyle(
                          color: Color.fromARGB(255, 97, 94, 94),
                          fontSize: 16)),
                ),
                // 业主姓名
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: const TextField(
                    maxLength: 15,
                    decoration: InputDecoration(
                      labelText: '姓名',
                      hintText: '请输入业主姓名',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    )
                  ),
                ),
                 // 性别
                Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(children: [
                      const Text(
                        '性别',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 20),
                      Radio(
                        value: 1,
                        groupValue: _formData['gender'],
                        onChanged: (value) {
                          setState(() {
                            _formData['gender'] = value ?? '';
                          });
                        },
                      ),
                      const Text('男'),
                      const SizedBox(width: 10),
                      Radio(
                        value: 0,
                        groupValue: _formData['gender'],
                        onChanged: (value) {
                          setState(() {
                            _formData['gender'] = value ?? '';
                          });
                        },
                      ),
                      const Text('女'),
                    ])),
                  // 业主手机号
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: const TextField(
                        keyboardType: TextInputType.phone,
                        maxLength: 11,
                        decoration: InputDecoration(
                          labelText: '手机号',
                          hintText: '请输入您的手机号',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        )),
                  ),
              ],
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
