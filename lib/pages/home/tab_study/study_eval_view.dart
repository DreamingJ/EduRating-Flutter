import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edu_rating_app/config.dart';
import 'package:edu_rating_app/pages/globalUserInfo.dart';
import 'package:edu_rating_app/utils/common_toast.dart';
import 'package:flutter/Material.dart';

class StudyEvalView extends StatefulWidget {
  List<Map<String, String>> dataList = [];
  num sum = 0;
  String courseID;
  String courseName;
  StudyEvalView({Key? key, required this.courseID, required this.courseName})
      : super(key: key);

  @override
  State<StudyEvalView> createState() => _StudyEvalViewState();
}

class _StudyEvalViewState extends State<StudyEvalView> {
  List<String> ques = [
    "1.课堂出勤纪律情况",
    "2.课堂听讲互动情况",
    "3.课余主动学习情况",
    "4.作业实验完成情况",
    "5.学习效果及知识技能掌握情况",
    "6.对于该门课的学生学习情况，我的意见或建议："
  ];

  List<String> answer = ["", "", "", "", "", ""];

  String gradeToStr(int num) {
    switch (num) {
      case 20:
        return "非常好(20)";
      case 18:
        return "较好(18)";
      case 16:
        return "一般(16)";
      case 14:
        return "较差(14)";
      case 12:
        return "非常差(12)";
      default:
        return "";
    }
  }

  @override
  void initState() {
    super.initState();
    for(var item in widget.dataList){
      item.values.toList()[0]="";
    }
    getStudyResItems();
  }

  Future<void> getStudyResItems() async {
    Map<String, String> params = {
      'userID': GlobalUserInfo.userID,
      'courseID': widget.courseID
    };
    var res = await Dio()
        .get(Config.BaseUrl + '/studyeval/res', queryParameters: params);
    //encode是字符串
    var resString = jsonEncode(res.data);
    //decode是可迭代数组
    var resJson = json.decode(resString);
    // resString["data"];

    if (resJson["studyItem1"] is int == true) {
      answer[0] = gradeToStr(resJson["studyItem1"]);
      answer[1] = gradeToStr(resJson["studyItem2"]);
      answer[2] = gradeToStr(resJson["studyItem3"]);
      answer[3] = gradeToStr(resJson["studyItem4"]);
      answer[4] = gradeToStr(resJson["studyItem5"]);
      answer[5] = resJson["studyComment"];

      for (int i = 0; i < ques.length; i++) {
        widget.dataList.add(Map.from({ques[i]: answer[i]}));
      }
      for (int i = 1; i < 6; i++) {
        widget.sum += resJson["studyItem$i"];
      }
      //刷新页面
      setState(() {
        //使用Navigator.push后页面就会重新build
      });
    } else {
      CommonToast.showToast("此门课还未评价，请先评价！");
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.white),
          title: const Text('查看评学结果'),
          centerTitle: true,
        ),
        body: Container(
            decoration: BoxDecoration(color: Color(0x08000000)),
            child: Column(children: [
              Container(
                  // height: 40.0,
                  decoration: BoxDecoration(color: Colors.white),
                  padding: EdgeInsets.only(
                      left: 13.0, right: 12.0, top: 10.0, bottom: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("课程名称：${widget.courseName}",
                          style: TextStyle(
                            fontSize: 16,
                          )),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('评学总分：',
                                style: TextStyle(
                                  fontSize: 16,
                                )),
                            Text("${widget.sum} 分",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue)),
                          ])
                    ],
                  )),
              Padding(padding: EdgeInsets.only(top: 10)),
              Expanded(
                  child: ListView(
                      shrinkWrap: true,
                      children:
                          widget.dataList.map((e) => getCard(e)).toList())),
              Padding(padding: EdgeInsets.only(top: 8)),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
                child: Text("完成查看"),
              ),
              Padding(padding: EdgeInsets.only(bottom: 10)),
            ])));
  }

  Widget getCard(Map<String, String>? data) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(25, 10, 10, 10),
                  child: /* Text(data.keys.toList()[0].question)*/
                      RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      text: (data != null) ? data.keys.toList()[0] : "",
                    ),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Material(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 25, 8),
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                child: data?.keys.toList()[0] != "6.对于该门课的学生学习情况，我的意见或建议："
                                    ? Row(
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text("你的评价：",
                                              style: TextStyle(
                                                fontSize: 15,
                                              )),
                                          Text(
                                              (data != null)
                                                  ? data.values.toList()[0]
                                                  : "",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      )
                                    : Container(
                                      //宽度超限时，加个container限制一下宽度
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.3,
                                        child: Row(
                                          
                                          children: [
                                            const Text("你的建议：",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                )),
                                            // RichText(text:
                                            Expanded(child: 
                                            Text(
                                                (data != null)
                                                    ? data.values.toList()[0]!="" ? data.values.toList()[0]
                                                    : "（未给出建议）"
                                                    :"",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold))
                                            ),
                                          ],
                                        )))),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
