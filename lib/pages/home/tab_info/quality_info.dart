// import 'package:conditional_questions/conditional_questions.dart';
import 'package:edu_rating_app/data/course_List.dart';
import 'package:flutter/Material.dart';

class QualityInfo extends StatefulWidget {
  const QualityInfo({Key? key, required this.courseID}) : super(key: key);
  final String courseID;

  @override
  State<QualityInfo> createState() => _QualityInfoState();
}

class _QualityInfoState extends State<QualityInfo> {
  @override
  Widget build(BuildContext context) {
    // final userID = Provider.of<UserIDProvider>(context).userID;
    var curCourse = dataList.firstWhere(
      (element) => element.courseID == widget.courseID,
    );
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "授课质量查看页",
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(children: [
            Padding(padding: EdgeInsets.only(top: 80)),
            Text(
              "课程名称：${curCourse.courseName}",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.normal),
            ),
            Text(
              "教师：${curCourse.teacherName}",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.normal),
            ),
            Padding(padding: EdgeInsets.only(bottom: 30)),
            Text(
              "该课程综合质量得分为：95分",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Text(
              "详细分析指标如图：",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.normal),
            ),
          ]),
        ));
  }
}
