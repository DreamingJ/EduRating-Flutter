//课程卡片组件，可复用，在不同页面点击卡片进行不同跳转
import 'package:edu_rating_app/data/course_List.dart';
import 'package:flutter/material.dart';


class CourseItemWidget extends StatelessWidget {
  bool isStudyKind;
  final CourseItemData data;
  CourseItemWidget(this.data,{Key? key,this.isStudyKind=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: (){
          //传入课程ID，在teachEval中展现评教表信息
          isStudyKind? 
          (data.isSubmit?  
          Navigator.pushNamed(context, '/studyEval/view?courseID=${data.courseID}&courseName=${Uri.encodeComponent(data.courseName)}',)
          :
          Navigator.pushNamed(context, '/studyEval?courseID=${data.courseID}&courseName=${Uri.encodeComponent(data.courseName)}',)
          )
          :
          (
          data.isSubmit?
          Navigator.pushNamed(context, '/teachEval/view?courseID=${data.courseID}&courseName=${Uri.encodeComponent(data.courseName)}',)
          :
          Navigator.pushNamed(context, '/teachEval?courseID=${data.courseID}&courseName=${Uri.encodeComponent(data.courseName)}',)
          );
        },
        child: Container(
            
            padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 10.0),
            // height: 95,
            child: Container(
                //内层白色部分
                padding: EdgeInsets.only(
                    left: 13.0, right: 10.0, top: 15.0, bottom: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: 
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.courseName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 21,
                            // fontStyle:
                          ),
                        ),
                        Text('ID:' + data.courseID),
                      ],
                    ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('教师：' + data.teacherName,
                              style: TextStyle(
                                fontSize: 16,
                              )),
                          Text('学期：' + data.semester),
                        ],
                      ),
                    ),
                    // const Padding(padding:EdgeInsets.only(left:12)),
                    data.isSubmit
                        ? const Text('已评价',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.green,
                              fontSize: 18,
                            ))
                        : const Text('待评价',
                            style: TextStyle(
                              fontStyle: FontStyle.normal,
                              color: Colors.blue,
                              fontSize: 18,
                            ))
                  ],
                ))));
  }
}
