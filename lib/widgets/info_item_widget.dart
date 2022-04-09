//课程卡片组件，可复用，在不同页面点击卡片进行不同跳转
import 'package:edu_rating_app/data/course_List.dart';
import 'package:flutter/material.dart';


class InfoItemWidget extends StatelessWidget {
  bool isPortraitKind;
  final CourseItemData data;
  InfoItemWidget(this.data,{Key? key,this.isPortraitKind=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: (){
          //传入课程ID，在teachEval中展现评教表信息
          isPortraitKind? 
          Navigator.pushNamed(context, '/portraitInfo?courseID=${data.courseID}',)
          :
          Navigator.pushNamed(context, '/qualityInfo?courseID=${data.courseID}',);
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
                  
                  ],
                ))));
  }
}
