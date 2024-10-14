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

   Widget _buildAddIdcardPhoto(String tag, String info) {
    return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.add, size: 30, color: Color.fromARGB(255, 85, 145, 175)),
          Text(
            '上传人像面照片',
            style: TextStyle(color: Color.fromARGB(255, 85, 145, 175)),
          ),
        ]);
  }

  Widget _buildIdcardPhoto(String tag, String photoUrl) {
    return Stack(children: [
      SizedBox(
          width: MediaQuery.of(context).size.width - 20,
          height: 300,
          child: Image.asset(photoUrl, fit: BoxFit.contain)),
      Positioned(
          right: 0,
          top: 0,
          child: GestureDetector(
            child: const Icon(Icons.delete, color: Colors.red),
            onTap: () {
              setState(() {
                _formData[tag] = '';
              });
            },
          ))
    ]);
  }
  
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
              padding: const EdgeInsets.only(top: 10, bottom: 40),
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
               // 业主信息
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text('本人身份证照片',
                      style: TextStyle(
                          color: Color.fromARGB(255, 97, 94, 94), fontSize: 16)),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: const Text('请拍摄证件原件，并使照片中证件边缘完整，文字清晰，光线均匀。',
                      style: TextStyle(
                          color: Color.fromARGB(255, 97, 94, 94), fontSize: 12)),
                ),
                // 身份证正面
                Container(
                    color: Colors.white,
                    height: 320,
                    padding: const EdgeInsets.all(10),
                    child: _formData['idcardFrontUrl'] == ''
                        ? _buildAddIdcardPhoto('idcardFrontUrl', '上传人像面照片')
                        : _buildIdcardPhoto(
                            'idcardFrontUrl', _formData['idcardFrontUrl'])),
                const SizedBox(height: 20),
                // 身份证反面
                Container(
                    color: Colors.white,
                    height: 320,
                    padding: const EdgeInsets.all(10),
                    child: _formData['idcardBackUrl'] == ''
                        ? _buildAddIdcardPhoto('idcardBackUrl', '上传国徽面照片')
                        : _buildIdcardPhoto(
                            'idcardBackUrl', _formData['idcardBackUrl'])),
                const SizedBox(height: 20),
              ],
            ),
            Container(
                padding: const EdgeInsets.all(10),
                color: Colors.white,
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
