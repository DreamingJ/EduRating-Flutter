import 'package:conditional_questions/conditional_questions.dart';
import 'package:edu_rating_app/data/course_List.dart';

class PortraitInfo extends StatefulWidget {
  const PortraitInfo({Key? key, required this.courseID}) : super(key: key);
  final String courseID;

  @override
  State<PortraitInfo> createState() => _PortraitInfoState();
}


class _PortraitInfoState extends State<PortraitInfo> {

  @override
  Widget build(BuildContext context) {
    // final userID = Provider.of<UserIDProvider>(context).userID;
    var curCourse = dataList.firstWhere(
      (element) => element.courseID == widget.courseID,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "画像查看页",
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
              "教师画像如下图：",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            Padding(padding: EdgeInsets.only(top: 180)),
            Text(
              "学生画像如下图：",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
          ]),
        )
    );
  }

}
