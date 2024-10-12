import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key, required this.userInfo});

  Map userInfo;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // 状态变量: 用户信息
  Map userInfo = {"id": "", "avatar": "", "nickName": null};

  final TextEditingController _nickNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print(widget.userInfo);
    setState(() {
      userInfo = widget.userInfo;
      _nickNameController.text = userInfo['nickName'];
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
      ),
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
                    ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: userInfo['avatar'] != ''
                            ? Image.network(userInfo['avatar'])
                            : Image.asset('assets/images/avatar_1.jpg',
                                width: 30, height: 30)),
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
