import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edu_rating_app/config.dart';
import 'package:edu_rating_app/pages/globalUserInfo.dart';
import 'package:edu_rating_app/pages/global_teachform.dart';
import 'package:edu_rating_app/routes.dart';
import 'package:edu_rating_app/utils/common_toast.dart';
import 'package:edu_rating_app/widgets/questoins/models.dart';
import 'package:edu_rating_app/widgets/questoins/widget.dart';
import 'package:flutter/material.dart';

class TeachingEvaluate extends StatefulWidget {
  String courseID;
  String courseName;
  TeachingEvaluate({Key? key, required this.courseID, required this.courseName})
      : super(key: key);

  @override
  State<TeachingEvaluate> createState() => _TeachingEvaluateState();
}

int quesToInt(String? ques) {
  if (ques == null) {
    return 0;
  } else {
    switch (ques) {
      case "非常同意(20)":
        return 20;
      case "同意(18)":
        return 18;
      case "一般(16)":
        return 16;
      case "不同意(14)":
        return 14;
      case "非常不同意(12)":
        return 12;
      default:
        return 0;
    }
  }
}

class _TeachingEvaluateState extends State<TeachingEvaluate> {
  final _key = GlobalKey<QuestionFormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              title: Container(
                  child: Column(
                children: [
                  Text(
                    "课程名称：${widget.courseName}",
                  ),
                ],
              )),
              centerTitle: true,
            ),
            preferredSize: Size.fromHeight(70)),
        body: ConditionalQuestions(
          key: _key,
          children: questions(),
          trailing: [
            ElevatedButton(
              onPressed: () async {
                if (_key.currentState!.validate()) {
                  Map<String, dynamic> params = {
                    'userID': GlobalUserInfo.userID,
                    'courseID': widget.courseID,
                    'teachItem1': quesToInt(GlobalTeachForm.teachForm[0]),
                    'teachItem2': quesToInt(GlobalTeachForm.teachForm[1]),
                    'teachItem3': quesToInt(GlobalTeachForm.teachForm[2]),
                    'teachItem4': quesToInt(GlobalTeachForm.teachForm[3]),
                    'teachItem5': quesToInt(GlobalTeachForm.teachForm[4]),
                    'teachComment': GlobalTeachForm.teachForm[5]
                  };
                  //必须先把map转成formdata，才能过dio，否则error400
                  var formdata = FormData.fromMap(params);
                  //response
                  try {
                    var res = await Dio()
                        .post(Config.BaseUrl + '/teacheval', data: formdata);
                    //转为json格式
                    var resString = json.decode(res.toString());

                    String code = resString['code'];
                    String msg = resString['msg'];

                    if (code == '0') {
                      CommonToast.showToast('提交成功！');
                      //清空
                      GlobalTeachForm.clean();
                      Navigator.pushNamedAndRemoveUntil(
                          context, Routes.teachIndex, (route) => false);
                    } else {
                      CommonToast.showToast(msg);
                    }
                  } catch (e) {
                    // print(e);
                    CommonToast.showToast("提交时错误，请联系管理员");
                  }
                } else {
                  CommonToast.showToast('请检查填写内容！');
                }
              },
              // color: Colors.green,
              child: Text('提交评价'),
            )
          ],
          leading: const [
            Text("请基于以下内容，对本课程进行打分",
                style: TextStyle(
                  fontSize: 16,
                )),
          ],
        ));
  }

  List<Question> questions() {
    return [
      PolarQuestion(
          question: "1.该课程注重道德修养和理想信念的培养，教师教学态度良好",
          answers: ["非常同意(20)", "同意(18)", "一般(16)", "不同意(14)", "非常不同意(12)"],
          isMandatory: true),
      PolarQuestion(
          question: "2.该课程教学目标清晰，内容具有挑战性，教学方法得当，师生互动良好",
          answers: ["非常同意(20)", "同意(18)", "一般(16)", "不同意(14)", "非常不同意(12)"],
          isMandatory: true),
      PolarQuestion(
          question: "3.该课程教学能够有效激发我主动学习的能力，能激发我的学习热情",
          answers: ["非常同意(20)", "同意(18)", "一般(16)", "不同意(14)", "非常不同意(12)"],
          isMandatory: true),
      PolarQuestion(
          question: "4.通过该课程，我的知识、能力、素质得到全面提升",
          answers: ["非常同意(20)", "同意(18)", "一般(16)", "不同意(14)", "非常不同意(12)"],
          isMandatory: true),
      PolarQuestion(
          question: "5.总体而言，该课程教学效果好，我会向同学推荐该课程",
          answers: ["非常同意(20)", "同意(18)", "一般(16)", "不同意(14)", "非常不同意(12)"],
          isMandatory: true),
      Question(
        question: "我的意见或建议：",
        //isMandatory: true,
        // validate: (field) {
        //   if (field.isEmpty) return "Field cannot be empty";
        //   return null;
        // },
      ),
      /* NestedQuestion(
      question: "The series will depend on your answer",
      answers: ["Yes", "No"],
      children: {
        'Yes': [
          PolarQuestion(
              question: "Have you ever taken medication for H1n1?",
              answers: ["Yes", "No"]),
          PolarQuestion(
              question: "Have you ever taken medication for Rabies?",
              answers: ["Yes", "No"]),
          Question(
            question: "Comments",
          ),
        ],
        'No': [
          NestedQuestion(
              question: "Have you sustained any injuries?",
              answers: [
                "Yes",
                "No"
              ],
              children: {
                'Yes': [
                  PolarQuestion(
                      question: "Did it result in a disability?",
                      answers: ["Yes", "No", "I prefer not to say"]),
                ],
                'No': [
                  PolarQuestion(
                      question: "Have you ever been infected with chicken pox?",
                      answers: ["Yes", "No"]),
                ]
              }), */
    ];
  }
}
