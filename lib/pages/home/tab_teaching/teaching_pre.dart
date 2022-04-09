import 'package:edu_rating_app/data/course_List.dart';
import 'package:edu_rating_app/data/teachEval_list.dart';
import 'package:edu_rating_app/pages/userIDProvider.dart';
import 'package:edu_rating_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/user_list.dart';

class TeachingPre extends StatelessWidget {
  const TeachingPre({Key? key}) : super(key: key);
  // const TeachingPre({Key? key, required this.userID}) : super(key: key);
  // final String userID;
  

  @override
  Widget build(BuildContext context) {
    final userID = Provider.of<UserIDProvider>(context).userID;
    // List<CourseItemData> curCourseList = [];
    int courseCount = 0;
    String semester = "2021-2022-1";
    UserListData curUser=UserListData(userID: '2018211563', userName: '蒋明君', userPwd: '2018211563');
    //user表的信息
    for (var user in userList) {
    if (user.userID == userID) {
      curUser =  user;
      break;
    }
    }
    //teachEval表信息
    if(curUser.status == "学生"){
      for(var item in teachEvalList){
        if(item.userID == userID){
          //待评价课程数量
          if(item.isSubmit == false){
            courseCount += 1;
          }
        }
      }
    }
    //其它角色，根据院系确定评课数
    else if(curUser.status == "教师同行"){
      for(var item in dataList){
        if(item.deptID == curUser.deptID && item.teacherName != curUser.userName){
          if(item.isSubmit == false){
            courseCount += 1;
          }
        }
      }
    }
    else{ 
      for(var item in dataList){
        if(item.deptID == curUser.deptID){
          if(item.isSubmit == false){
            courseCount += 1;
          }
        }
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('评教首页'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.only(left: 40, top: 80, right: 30, bottom: 20),
          child: Column(children: [
            Container(
              padding:
                  EdgeInsets.only(left: 30, top: 26, right: 30, bottom: 20),
              child: Text(
                "${curUser.userName}，欢迎!",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
            ),
            
            Text(
              "${semester} 学期",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Text(
              "类别：${curUser.status}期末评教",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Text(
              "您还有 ${courseCount} 门课程需要进行评教",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 5),),
            // Text("您的ID是：$userID"),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                  child: const Text("开始评教",style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500)),
                  onPressed: () {
                    Navigator.pushNamed(
                                context,
                                Routes.teachIndex
                                // '/teachIndex?userID=$userID',
                              );
                  }),
            )
          ]),
        ));
  }
}
