import 'dart:async';

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 1. 获取短信验证码倒计时
  int _countdown = 60;
  bool _isCountingdown = false;
  Timer? _timer;
  void _startCountdown() {
    // 1.1 判断是否在倒计时
    if (_isCountingdown) {
      return;
    }
    // 1.2 设置开始倒计时
    _isCountingdown = true;
    // 1.3 开启倒计时
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _isCountingdown = false;
          _countdown = 60;
          _timer!.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('登录'),
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        body: Container(
            padding: const EdgeInsets.all(20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              const Row(
                children: [
                  Text('登录',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Text('加入享+, 让生活更轻松', style: TextStyle(fontSize: 15))
                ],
              ),
              const SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: '手机号',
                        hintText: '请输入手机号',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shadowColor: Colors.transparent,
                      foregroundColor: const Color.fromARGB(255, 85, 145, 175),
                      minimumSize: const Size(100, 50),
                    ),
                    onPressed: () {
                      _startCountdown();
                    },
                    child: _isCountingdown ? Text('$_countdown s后重新获取', style: const TextStyle(color: Colors.grey),) : const Text('获取验证码'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const TextField(
                decoration: InputDecoration(
                  labelText: '验证码',
                  hintText: '请输入6位验证码',
                ),
              ),
              const SizedBox(height: 8),
              const Row(children: [
                Text('未注册手机号经验证后将自动登录',
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ]),
              const SizedBox(height: 50),
              Row(children: [
                Expanded(
                    child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 85, 145, 175),
                    minimumSize: const Size(100, 50),
                  ),
                  onPressed: () {},
                  child: const Text('登录',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ))
              ])
            ])));
  }
}
