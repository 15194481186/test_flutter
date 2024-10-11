import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                        child: Image.asset('assets/images/avatar_1.jpg',
                            width: 30, height: 30)),
                    const Icon(Icons.arrow_forward_ios, size: 12)
                  ],
                )
              ],
            ),
          ),
          const Row(
            children: [
              Text('昵称'),
              Spacer(),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      hintText: '请输入昵称', border: InputBorder.none),
                  textAlign: TextAlign.right,
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 12)
            ],
          )
        ],
      ),
    );
  }
}
