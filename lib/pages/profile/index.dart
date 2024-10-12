import 'package:dio/dio.dart';
import 'package:enjoy_plus_hm/utils/evntbus.dart';
import 'package:enjoy_plus_hm/utils/http.dart';
import 'package:enjoy_plus_hm/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


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
  void showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              padding: const EdgeInsets.all(10),
              height: 180,
              child: Column(
                children: [
                  ListTile(
                      leading: const Icon(Icons.camera_alt),
                      title: const Text('拍照'),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                      onTap: () async {
                        // 调用相机
                        ImagePicker picker = ImagePicker();
                        final XFile? photo =
                            await picker.pickImage(source: ImageSource.camera);
                        if (photo != null) {
                          uploadAvatar(photo.path);
                        }
                      }),
                  ListTile(
                      leading: const Icon(Icons.image),
                      title: const Text('相册'),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                      onTap: () async {
                        // 调用相册
                        ImagePicker picker = ImagePicker();
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          uploadAvatar(image.path);
                        }
                      })
                ],
              ));
        });
  }

  /// 上传图片
  uploadAvatar(String imagePath) async {
    try {
      // 1. 包装一个FormData对象
      FormData fd = FormData.fromMap(
          {"file": await MultipartFile.fromFile(imagePath), "type": "avatar"});
      // 2. 调用上传接口
      var res = await http.post('/upload', data: fd);
      if (res['code'] != 10000) return ToastUtil.showError('上传图片失败');
      // print(res);
      setState(() {
        userInfo['avatar'] = res['data']['url'];
        ToastUtil.showSuccess('上传图片成功');
      });
    } catch (e) {
      ToastUtil.showError('上传图片失败');
    } finally {
      Navigator.pop(context);
    }
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
                          showBottomSheet();
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
