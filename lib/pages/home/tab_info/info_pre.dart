import 'package:edu_rating_app/pages/globalUserInfo.dart';
import 'package:edu_rating_app/routes.dart';
import 'package:flutter/material.dart';

class TabInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("信息页"),
          centerTitle: true,
        ),
        body: Column(
          children: [
          Container(
            decoration: BoxDecoration(
                    color: Colors.white60),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: 32.0, right: 32.0, top: 15.0, bottom: 20.0),
                child: Image.asset("assets/img/BUPTlogo.jpeg",width: 110,),),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      GlobalUserInfo.userName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                        // fontStyle:
                      ),
                    ),
                    Text('ID:' + GlobalUserInfo.userID),
                    Padding(padding: EdgeInsets.only(
                    top: 10.0),),
                    Text('身份：' + GlobalUserInfo.status),
                    Text('院系：计算机学院',),
                    
                  ],
                ),
              ),
            ],
          )),
          Expanded(
              child: ListView(
            children: ListTile.divideTiles(
              context: context,
              tiles: [
                ListTile(
                  leading:Icon( Icons.assessment_outlined,size: 32.0
                  ),
                  title: Text('课程综合质量',style: TextStyle(
                          fontSize: 18,fontWeight: FontWeight.w500
                        )),
                  // subtitle: Text('A strong animal'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.pushNamed(context, '/infoIndex?isPortraitKind=${false}');
                  },
                  selected: true,
                ),
                ListTile(
                  leading: Icon( Icons.assignment_ind,size: 34.0
                  ),
                  title: Text('查看画像',style: TextStyle(
                          fontSize: 18,fontWeight: FontWeight.w500
                        )),
                  subtitle: Text('教师、学生群体'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.pushNamed(context, '/infoIndex?isPortraitKind=${true}');
                  },
                ),
                ListTile(
                  leading: Icon( Icons.event_available,size: 34.0,
                  ),
                  title: Text('评学管理',style: TextStyle(
                          fontSize: 17,fontWeight: FontWeight.w500
                        )),
                  subtitle: Text('仅教师可使用'),
                  trailing: Icon(Icons.keyboard_arrow_right,),
                  onTap: () {
                    Navigator.pushNamed(context, Routes.adminstudy);
                  },
                  enabled: GlobalUserInfo.status=="教师"?true:false,
                ),
                ListTile(
                  leading: Icon( Icons.highlight_off,size: 33.0
                  ),
                  title: Text('退出登录',style: TextStyle(
                          fontSize: 19,fontWeight: FontWeight.w500
                        )),
                  // subtitle: Text('Provides wool'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(context, Routes.login, ModalRoute.withName(Routes.login));
                  },
                ),
              ],
            ).toList(),
          ))
        ]));
  }
}
