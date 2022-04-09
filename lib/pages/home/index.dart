import 'package:edu_rating_app/pages/home/tab_info/info_pre.dart';
import 'package:edu_rating_app/pages/home/tab_study/study_pre.dart';
import 'package:edu_rating_app/pages/home/tab_teaching/teaching_index.dart';
import 'package:edu_rating_app/pages/home/tab_teaching/teaching_pre.dart';
import 'package:edu_rating_app/pages/userIDProvider.dart';
import 'package:edu_rating_app/widgets/page_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 1.导航栏准备3个tab内容
Widget tabView(int index,String userID){
  if(index == 0)  return TeachingPre();
  else if(index == 1) return StudyPre();
  else  return TabInfo();
}
// List<Widget> tabViewList=[
//   TeachingPre(),
//   PageContent(name:'评学'),
//   PageContent(name:'查看'),
// ];

//2.准备BottomNavigationBar的3个item
List<BottomNavigationBarItem> barItemList=[
  BottomNavigationBarItem(icon: Icon(Icons.school), label: '评教' ),
  BottomNavigationBarItem(icon: Icon(Icons.edit), label: '评学' ),
  BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: '查看' ),
];

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);
  // const HomePage({ Key? key , required this.userID}) : super(key: key);
  // final String userID;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userID = Provider.of<UserIDProvider>(context).userID;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('BottomNavigationBar Sample'),
      // ),
      body: tabView(_selectedIndex,  userID),
      bottomNavigationBar: BottomNavigationBar(
        items: barItemList,
        currentIndex: _selectedIndex,
        iconSize: 30.0,
        unselectedFontSize: 15.0,
        selectedFontSize: 16.0,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}