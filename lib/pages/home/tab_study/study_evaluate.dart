import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edu_rating_app/config.dart';
import 'package:edu_rating_app/pages/globalUserInfo.dart';
import 'package:edu_rating_app/pages/global_teachform.dart';
import 'package:edu_rating_app/routes.dart';
import 'package:edu_rating_app/widgets/questoins/models.dart';
import 'package:edu_rating_app/widgets/questoins/widget.dart';
// import 'package:edu_rating_app/routes.dart';
import 'package:edu_rating_app/utils/common_toast.dart';
import 'package:flutter/Material.dart';

class StudyEvaluate extends StatefulWidget {
  const StudyEvaluate({Key? key, required this.courseID, required this.courseName}) : super(key: key);
  final String courseID;
  final String courseName;

  @override
  State<StudyEvaluate> createState() => _StudyEvaluateState();
}

int quesToInt(String? ques) {
  if (ques == null) {
    return 0;
  } else {
    switch (ques) {
      case "非常好(20)":
        return 20;
      case "较好(18)":
        return 18;
      case "一般(16)":
        return 16;
      case "较差(14)":
        return 14;
      case "非常差(12)":
        return 12;
      default:
        return 0;
    }
  }
}

class _StudyEvaluateState extends State<StudyEvaluate> {
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
                    'studyItem1': quesToInt(GlobalTeachForm.teachForm[0]),
                    'studyItem2': quesToInt(GlobalTeachForm.teachForm[1]),
                    'studyItem3': quesToInt(GlobalTeachForm.teachForm[2]),
                    'studyItem4': quesToInt(GlobalTeachForm.teachForm[3]),
                    'studyItem5': quesToInt(GlobalTeachForm.teachForm[4]),
                    'studyComment': GlobalTeachForm.teachForm[5]
                  };
                  //必须先把map转成formdata，才能过dio，否则error400
                  var formdata = FormData.fromMap(params);
                  //response
                  try {
                    var res = await Dio()
                        .post(Config.BaseUrl + '/studyeval', data: formdata);
                    //转为json格式
                    var resString = json.decode(res.toString());

                    String code = resString['code'];
                    String msg = resString['msg'];

                    if (code == '0') {
                      CommonToast.showToast('提交成功！');
                      //清空
                      GlobalTeachForm.clean();
                      Navigator.pushReplacementNamed(
                          context, Routes.studyIndex);
                      // Navigator.pop(context);
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
          question: "1.课堂出勤纪律情况",
          answers: ["非常好(20)", "较好(18)", "一般(16)", "较差(14)", "非常差(12)"],
          isMandatory: true),
      PolarQuestion(
          question: "2.课堂听讲互动情况",
          answers: ["非常好(20)", "较好(18)", "一般(16)", "较差(14)", "非常差(12)"],
          isMandatory: true),
      PolarQuestion(
          question: "3.课余主动学习情况",
          answers: ["非常好(20)", "较好(18)", "一般(16)", "较差(14)", "非常差(12)"],
          isMandatory: true),
      PolarQuestion(
          question: "4.作业实验完成情况",
          answers: ["非常好(20)", "较好(18)", "一般(16)", "较差(14)", "非常差(12)"],
          isMandatory: true),
      PolarQuestion(
          question: "5.学习效果及知识技能掌握情况",
          answers: ["非常好(20)", "较好(18)", "一般(16)", "较差(14)", "非常差(12)"],
          isMandatory: true),
      Question(
        question: "6.对于该门课的学生学习情况，我的意见或建议：",
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
