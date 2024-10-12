import 'dart:async';

import 'package:enjoy_plus_hm/utils/evntbus.dart';
import 'package:enjoy_plus_hm/utils/http.dart';
import 'package:enjoy_plus_hm/utils/toast.dart';
import 'package:enjoy_plus_hm/utils/token.dart';
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

  // 2. 定义两个控制器用于获取输入框中的值
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  // 3. 获取短信验证码
  void _getCode() async {
    // 3.1 获取输入框中的值
    String mobile = _phoneController.text;

    // 3.2 对手机号进行校验(非空, 正则)
    if (mobile.isEmpty) {
      return ToastUtil.showError('请输入手机号');
    }

    RegExp reg = RegExp(r'^1[3-9]\d{9}$');
    if (!reg.hasMatch(mobile)) {
      return ToastUtil.showError('请输入合法的手机号');
    }

    // 3.3 开始倒计时
    _startCountdown();

    // 3.4 调用获取验证码接口
    var res = await http.get('/code', params: {'mobile': mobile});
    if (res['code'] != 10000) return ToastUtil.showError('获取验证码失败');

    // 3.5 把验证码回显到验证码输入框中
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _codeController.text = res['data']['code'];
      });
    });
  }

  // 4. 登录
  void _login() async {
    // 4.1 获取输入框中的值
    String mobile = _phoneController.text;
    String code = _codeController.text;
    // 4.2 对手机号进行校验(非空, 正则)
    if (mobile.isEmpty) {
      return ToastUtil.showError('请输入手机号');
    }
    RegExp reg = RegExp(r'^1[3-9]\d{9}$');
    if (!reg.hasMatch(mobile)) {
      return ToastUtil.showError('请输入合法的手机号');
    }
    // 4.3 对验证码进行校验(非空, 正则)
    if (code.isEmpty) {
      return ToastUtil.showError('请输入验证码');
    }
    RegExp reg1 = RegExp(r'^\d{6}$');
    if (!reg1.hasMatch(code)) {
      return ToastUtil.showError('请输入6位数字验证码');
    }
    // 4.4 调用登录接口
    var res = await http.post('/login', data: {
      'mobile': mobile,
      'code': code,
    });
    if (res['code'] != 10000) return ToastUtil.showError('登录失败');
    ToastUtil.showSuccess('登录成功');
    // 4.5 存储token
    TokenManager tokenManager =  TokenManager();
    await tokenManager.saveToken(res['data']['token']);
    // 4.5 清除定时器
    _timer?.cancel();

    eventBus.fire(RefreshMineEvent());

    // 4.6 返回上一页
    Navigator.pop(context);
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
                  Expanded(
                    child: TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      maxLength: 11,
                      decoration: const InputDecoration(
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
                      _getCode();
                    },
                    child: _isCountingdown
                        ? Text(
                            '$_countdown s后重新获取',
                            style: const TextStyle(color: Colors.grey),
                          )
                        : const Text('获取验证码'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _codeController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: const InputDecoration(
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
                  onPressed: () {
                    _login();
                  },
                  child: const Text('登录',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ))
              ])
            ])));
  }
}
