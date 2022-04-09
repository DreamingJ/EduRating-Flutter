import 'package:conditional_questions/conditional_questions.dart';
import 'package:edu_rating_app/data/course_List.dart';
import 'package:edu_rating_app/data/teachEval_list.dart';
import 'package:edu_rating_app/pages/home/tab_teaching/teaching_index.dart';
import 'package:edu_rating_app/pages/userIDProvider.dart';
import 'package:edu_rating_app/routes.dart';
import 'package:edu_rating_app/utils/common_toast.dart';
import 'package:flutter/material.dart';

class TeachingEvaluate extends StatefulWidget {
  const TeachingEvaluate({Key? key, required this.courseID}) : super(key: key);
  final String courseID;

  @override
  State<TeachingEvaluate> createState() => _TeachingEvaluateState();
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

class _TeachingEvaluateState extends State<TeachingEvaluate> {
  final _key = GlobalKey<QuestionFormState>();

  @override
  Widget build(BuildContext context) {
    final userID = Provider.of<UserIDProvider>(context).userID;
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
            //TODO：此组件能正常提交表单吗？能进行评教结果展示吗？不行的话自己封装container+form
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
                    //TODO:提交时对应的是评教表，使用人id+课id(包含课名、开课时间) , 人ID应该存，不要传来传去

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
                      //TODO：用pop跳转不会刷新，需要刷新，本地1.0版用构造函数，无法持久化
                      Future.delayed(Duration(seconds: 1), () {
                        Navigator.pop(context);
                        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:  (context)=>TabTeaching()),(route) => route == null);
                      });
                        // print("validated!");
                        // return;
                      }
                      else{
                      CommonToast.showToast('请检查填写内容！');
                    }},
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
