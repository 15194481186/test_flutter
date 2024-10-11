import 'package:enjoy_plus_hm/utils/http.dart';
import 'package:enjoy_plus_hm/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class NoticeDetail extends StatefulWidget {
  const NoticeDetail({super.key});

  @override
  State<NoticeDetail> createState() => _NoticeDetailState();
}

class _NoticeDetailState extends State<NoticeDetail> {
  Map notifyDetail = {};
  
  

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Map args = ModalRoute.of(context)!.settings.arguments as Map;
    if (args.isNotEmpty) {
      getNotifyDetail(args['id']);
    } else {
      ToastUtil.showError('缺少参数');
    }
  }

  getNotifyDetail(String id) async {
    try {
      final res = await http.get('/announcement/$id');
      if(res['code'] != 10000) return ToastUtil.showError('获取数据失败');
      ToastUtil.showSuccess('获取公告数据成功~');
      setState(() {
        notifyDetail = res['data'];
      });
    } catch (e) {
      ToastUtil.showError('网络请求错误');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('公告详情'),
        ),
        body: ListView(children: [
          Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 标题
                    Text(notifyDetail['title'] ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(notifyDetail['creatorName'] ?? '',
                              style: const TextStyle(color: Colors.grey)),
                          Text(notifyDetail['createdAt'] ?? '',
                              style: const TextStyle(color: Colors.grey))
                        ]),
                    const SizedBox(height: 10),
                    // 内容
                    Html(
                      data: notifyDetail['content'] ?? '',
                    )
                  ]))
        ]));
  }
}
