// import 'package:conditional_questions/conditional_questions.dart';
import 'package:edu_rating_app/widgets/questoins/models.dart';
import 'package:edu_rating_app/widgets/questoins/widget.dart';
import 'package:edu_rating_app/data/course_List.dart';
import 'package:edu_rating_app/data/teachEval_list.dart';
import 'package:edu_rating_app/pages/userIDProvider.dart';
// import 'package:edu_rating_app/routes.dart';
import 'package:edu_rating_app/utils/common_toast.dart';
import 'package:flutter/Material.dart';
import 'package:provider/provider.dart';
// import 'package:flutter/material.dart';

class StudyEvaluate extends StatefulWidget {
  const StudyEvaluate({Key? key, required this.courseID}) : super(key: key);
  final String courseID;

  @override
  State<StudyEvaluate> createState() => _TeachingEvaluateState();
}

int quesToInt(String ques) {
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

class _TeachingEvaluateState extends State<StudyEvaluate> {
  final _key = GlobalKey<QuestionFormState>();

  @override
  Widget build(BuildContext context) {
    final userID = Provider.of<UserInfoProvider>(context).userID;
    var curCourse = dataList.firstWhere(
      (element) => element.courseID == widget.courseID,
    );
    return Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              title: Container(
                  child: Column(
                children: [
                  Text(
                    "课程名称：${curCourse.courseName}",
                  ),
                ],
              )),
              centerTitle: true,
            ),
            preferredSize: Size.fromHeight(70)),
        body:
            ConditionalQuestions(
          key: _key,
          children: questions(),
          trailing: [
            //已评价就是【完成】按钮
            curCourse.isSubmit
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("完成查看"),
                  )
                : ElevatedButton(

                    onPressed: () async {
                      if (_key.currentState!.validate()) {
                        //提交表单项，但此时不会起效
                      for (var item in teachEvalList) {
                        if (item.courseID == curCourse &&
                            item.userID == userID) {
                          item.isSubmit = true;
                          item.teachItem1 =
                              quesToInt(questions()[0].answer.text);
                          item.teachItem2 =
                              quesToInt(questions()[1].answer.text);
                          item.teachItem3 =
                              quesToInt(questions()[2].answer.text);
                          item.teachItem4 =
                              quesToInt(questions()[3].answer.text);
                          item.teachItem5 =
                              quesToInt(questions()[4].answer.text);
                          item.teachSuggest = questions()[5].answer.text;
                        }
                      }
                      //更新字段，
                      for (var item in dataList) {
                        if (item.courseID == curCourse) {
                          item.isSubmit = true;
                        }
                      }
                      CommonToast.showToast('提交成功！');
                      Future.delayed(Duration(seconds: 1), () {
                        Navigator.pop(context);
                        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:  (context)=>TabStudy()),(route) => route == null);
                      });
                        // print("validated!");
                        // return;
                      }
                      else{
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
        question: "对于该门课的学生学习情况，我的意见或建议：",
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
