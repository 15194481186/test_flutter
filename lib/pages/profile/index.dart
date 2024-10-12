import 'package:enjoy_plus_hm/utils/evntbus.dart';
import 'package:enjoy_plus_hm/utils/http.dart';
import 'package:enjoy_plus_hm/utils/toast.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key, required this.userInfo});

  Map userInfo;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // 状态变量: 用户信息
  Map userInfo = {"id": "", "avatar": null, "nickName": null};

  final TextEditingController _nickNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print(widget.userInfo);
    setState(() {
      userInfo = widget.userInfo;
      _nickNameController.text = userInfo['nickName'] ?? '';
    });
  }

  /// 修改昵称
  void editNickName() async {
    // 1. 获取输入的值
    String nickName = _nickNameController.text;
    if (nickName.isEmpty) {
      return ToastUtil.showError('昵称不能为空');
    }
    if (nickName.length > 10) {
      return ToastUtil.showError('昵称长度不能超过10个字符');
    }
    // 2. 发送请求
    try {
      await http.put('/userInfo', data: {'nickName': nickName});
      ToastUtil.showSuccess('昵称修改成功');
    } catch (e) {
      ToastUtil.showError('网络出现问题');
    }
  }

  /// 上传图片
  void uploadAvatar() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              padding: const EdgeInsets.all(10),
              child: const Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text('拍照'),
                    trailing: Icon(Icons.arrow_forward_ios_rounded)
                  ),
                  ListTile(
                    leading: Icon(Icons.image),
                    title: Text('相册'),
                     trailing: Icon(Icons.arrow_forward_ios_rounded)
                  )
                ],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text('个人信息'),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                // 发出通知
                eventBus.fire(BackMineEvent());
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back))),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          SizedBox(
            height: 40,
            child: Row(
              children: [
                const Text('头像', style: TextStyle(fontSize: 16)),
                const Spacer(),
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          uploadAvatar();
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: userInfo['avatar'] != null
                                ? Image.network(userInfo['avatar'])
                                : Image.asset('assets/images/avatar_1.jpg',
                                    width: 30, height: 30))),
                    const Icon(Icons.arrow_forward_ios, size: 12)
                  ],
                )
              ],
            ),
          ),
          Row(
            children: [
              const Text('昵称'),
              const Spacer(),
              Expanded(
                child: TextField(
                  controller: _nickNameController,
                  decoration: const InputDecoration(
                      hintText: '请输入昵称', border: InputBorder.none),
                  textAlign: TextAlign.right,
                  // 输入内容结束
                  onEditingComplete: () {
                    editNickName();
                  },
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 12)
            ],
          )
        ],
      ),
    );
  }
}
