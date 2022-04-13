import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:edu_rating_app/config.dart';
// import 'package:edu_rating_app/pages/userIDProvider.dart';
import 'package:edu_rating_app/pages/globalUserInfo.dart';
import 'package:edu_rating_app/routes.dart';
import 'package:edu_rating_app/utils/dio_http.dart';
import 'package:flutter/material.dart';



class TeachingPre extends StatefulWidget {
  const TeachingPre({Key? key}) : super(key: key);

  @override
  State<TeachingPre> createState() => _TeachingPreState();
}

class _TeachingPreState extends State<TeachingPre> {
  int teachEvalCount = 0;
  int year = DateTime.now().year;
  int seme = DateTime.now().month > 3 ? 2:1;
  String curUserName =  GlobalUserInfo.userName;
    String curUserStatus =  GlobalUserInfo.status;
    String semester = "2021-2022-1";
    
  @override
  void initState() {
    super.initState();
    //学期，增加字段or分表
    semester = (year-1).toString()+"-"+year.toString()+"-"+seme.toString();
    String curUserID = GlobalUserInfo.userID;
    getTeachEvalNum(curUserID);
  }

  Future<void> getTeachEvalNum(String userID) async{
    Map<String, String> params = {'userID': userID};
    // var res = await Dio().get(Config.BaseUrl+'/teacheval/num',queryParameters: params);
    var res = await DioHttp.of(context).get('/teacheval/num',params: params);
    var resString = json.decode(res.toString());
    teachEvalCount = resString["data"];
    //刷新页面
    setState(() {
      //使用Navigator.push后页面就会重新build
    });
    }

  @override
  Widget build(BuildContext context) {
    //build是用来构建使视图的，pop时build执行但initstate不执行

    //数据库中取回curuser信息
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
              "类别：${curUserStatus}期末评教",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Text(
              "您还有 ${teachEvalCount} 门课程需要进行评教",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 5),
            ),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                  child: const Text("开始评教",
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.w500)),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.teachIndex
                        // '/teachIndex?userID=$userID',
                        );
                  }),
            )
          ]),
        ));
  }
}
