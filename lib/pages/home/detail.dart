import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class NoticeDetail extends StatefulWidget {
  const NoticeDetail({super.key});

  @override
  State<NoticeDetail> createState() => _NoticeDetailState();
}

class _NoticeDetailState extends State<NoticeDetail> {
  Map notifyDetail = {
    "id": "3",
    "content":
        "<p>尊敬的住户:</p>\r\n<p>你们好!现本小区已进入装修阶段,进出苑区人员日益增多,管理处为加强小区人员进出管理,确保苑区的安全和谐,须对苑区住户办理业主卡,住户须凭业主卡进出苑区。请业主于近期内到管理处办理,谢谢合作!</p>\r\n<p>办理业主卡需带资料:</p>\r\n<p>一、业主及家人:</p>\r\n<p>1寸照片2张,身份证复印件1张</p>\r\n<p>二、租住户:</p>\r\n<p>租房合同复件;身份证复件1份;1寸照片2张</p>\r\n<p>三、公司员工:</p>\r\n<p>租房合同复件(限租住户);公司营业执照复件1份;公司介绍信;身份证复件1张;1寸照片2张。</p>",
    "title": "小区关于办理业主卡的通知",
    "createdAt": "2022-09-11 14:16:57",
    "creatorName": "传智教育"
  };

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
