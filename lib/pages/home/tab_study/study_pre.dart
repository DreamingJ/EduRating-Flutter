import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edu_rating_app/config.dart';
import 'package:edu_rating_app/pages/globalUserInfo.dart';
import 'package:edu_rating_app/routes.dart';
// import 'package:edu_rating_app/utils/dio_http.dart';
import 'package:flutter/material.dart';


class StudyPre extends StatefulWidget {
  const StudyPre({Key? key}) : super(key: key);

  @override
  State<StudyPre> createState() => _StudyPreState();
}

class _StudyPreState extends State<StudyPre> {
  // const StudyPre({Key? key, required this.userID}) : super(key: key);
  int studyEvalCount = 0;
  int year = DateTime.now().year;
  int seme = DateTime.now().month > 3 ? 2:1;
  String curUserID = GlobalUserInfo.userID;
  String curUserName =  GlobalUserInfo.userName;
    String curUserStatus =  GlobalUserInfo.status;
    String semester = "2021-2022-1";
    
  @override
  void initState() {
    super.initState();
    //学期，增加字段or分表
    semester = (year-1).toString()+"-"+year.toString()+"-"+seme.toString();
  }

  Future<void> getStudyEvalNum(String userID) async{
    Map<String, String> params = {'userID': userID};
    var res = await Dio().get(Config.BaseUrl+'/studyeval/num',queryParameters: params);
    // var res = await DioHttp.of(context).get('/studyeval/num',params: params);
    var resString = json.decode(res.toString());
    studyEvalCount = resString["data"];
    //刷新页面
    setState(() {
      //使用Navigator.push后页面就会重新build
    });
    }
  @override
  Widget build(BuildContext context) {
    getStudyEvalNum(curUserID);
    return Scaffold(
        appBar: AppBar(
          title: Text('评学首页'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.only(left: 40, top: 80, right: 30, bottom: 20),
          child: Column(children: [
            Container(
              padding:
                  EdgeInsets.only(left: 30, top: 26, right: 30, bottom: 20),
              child: Text(
                "${curUserName}，欢迎!",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
            ),
            
            Text(
              "${semester} 学期",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Text(
              "类别：${curUserStatus}评学",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Text(
              "您还有 ${studyEvalCount} 门课程需要进行评学",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 5),),
            // Text("您的ID是：$userID"),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
                  child: const Text("开始评学",style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500)),
                  onPressed: () {
                    Navigator.pushNamed(
                                context,
                                Routes.studyIndex
                                // '/teachIndex?userID=$userID',
                              );
                  }),
            )
          ]),
        ));
  }
}
