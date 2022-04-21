import 'package:edu_rating_app/pages/admin/user/user_manage.dart';
import 'package:edu_rating_app/pages/home/tab_info/info_pre.dart';
import 'package:edu_rating_app/pages/home/tab_study/study_pre.dart';
import 'package:edu_rating_app/routes.dart';
import 'package:flutter/material.dart';

// 1.导航栏准备3个tab内容
Widget tabView(int index) {
  if (index == 0)
    return UserManagePage();
  else if (index == 1)
    return StudyPre();
  else
    return TabInfo();
}
// List<Widget> tabViewList=[
//   TeachingPre(),
//   PageContent(name:'评学'),
//   PageContent(name:'查看'),
// ];

//2.准备BottomNavigationBar的3个item
List<BottomNavigationBarItem> barItemList = [
  BottomNavigationBarItem(icon: Icon(Icons.school), label: '评教'),
  BottomNavigationBarItem(icon: Icon(Icons.edit), label: '评学'),
  BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: '查看'),
];

class adminHomePage extends StatefulWidget {
  const adminHomePage({Key? key}) : super(key: key);
  // const HomePage({ Key? key , required this.userID}) : super(key: key);
  // final String userID;

  @override
  State<adminHomePage> createState() => _adminHomePageState();
}

class _adminHomePageState extends State<adminHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(padding: EdgeInsets.only(left: 55)),
                const Text('鸿雁评课后台管理系统'),
                IconButton(onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(context, Routes.adminlogin, (route) => false);
                }, icon: const Icon(Icons.logout))
              ],
            ),
            centerTitle: true,
            // backgroundColor: Colors.green,//设置标题栏的背景颜色
            bottom: TabBar(
              // labelColor: Colors.green,
              // labelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
              tabs: [
                Tab(
                  child: Row(
                    children: [
                      Icon(Icons.person),
                      Padding(padding: EdgeInsets.only(left: 3)),
                      Text("用户管理", style: TextStyle(fontSize: 17))
                    ],
                  ),
                  // icon: Icon(Icons.info_outline),
                  // text: "用户管理",
                ),
                Tab(
                  child: Row(
                    children: [
                      Icon(Icons.school),
                      Padding(padding: EdgeInsets.only(left: 3)),
                      Text("评教管理", style: TextStyle(fontSize: 17))
                    ],
                  ),
                  // icon: Icon(Icons.school),
                  // text: "评教管理",
                ),
                Tab(
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      Padding(padding: EdgeInsets.only(left: 3)),
                      Text("评学管理", style: TextStyle(fontSize: 17))
                    ],
                  ),
                  // icon: Icon(Icons.edit),
                  // text: "评学管理",
                )
              ],
              onTap: _onItemTapped,
            ),
          ),
          body: tabView(_selectedIndex),
        ));
  }
}
