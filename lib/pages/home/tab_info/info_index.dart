
import 'package:edu_rating_app/data/course_List.dart';
import 'package:edu_rating_app/data/teachEval_list.dart';
import 'package:edu_rating_app/pages/userIDProvider.dart';
import 'package:edu_rating_app/widgets/course_item_wigdet.dart';
import 'package:edu_rating_app/widgets/info_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/user_list.dart';

class InfoIndex extends StatefulWidget {
  // final String userID;
  List<CourseItemData> curCourseList=[]; //要渲染的课程列表
  final String inputValue=""; //搜索框值
  bool isPortraitKind;
  InfoIndex({
    Key? key, required this.isPortraitKind
    // required this.userID,
  }) : super(key: key);

  @override
  State<InfoIndex> createState() => _InfoIndexState();
}

class _InfoIndexState extends State<InfoIndex> {
  String _searchword = '';
  TextEditingController? _controller;
  UserListData curUser=UserListData(userID: '2018211563', userName: '蒋明君', userPwd: '2018211563');

  @override
  void initState() {
    _controller = TextEditingController(text: widget.inputValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userID = Provider.of<UserInfoProvider>(context).userID;
    //curList  查询——加入——展现
      curUser =  userList.firstWhere((element) => element.userID == userID);
      widget.curCourseList=[];

    //teachEval表信息
    if(curUser.status == "学生"){
      for(var item in teachEvalList){
        if(item.userID == userID){
          //在选课表中找课程，把课程表中的项加入进list
          widget.curCourseList.add(dataList.firstWhere((element) => item.courseID ==element.courseID));
        }
      }
    }
    //其它角色，根据院系确定评课数
    else if(curUser.status == "教师同行"){
      widget.curCourseList = dataList.where((element) => element.deptID == curUser.deptID && element.teacherName != curUser.userName).toList();
    }
    else{ 
      // for(var item in dataList){
      //   if(item.deptID == curUser.deptID){
      //     widget.curCourseList.add(item);
      //   }
      // }
      //这一句和上面完成的功能一样
      widget.curCourseList = dataList.where((element) => element.deptID == curUser.deptID).toList();
    }
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.white),
          title: const Text('选择课程'),
          centerTitle: true,
        ),
        body: Container(
            decoration: BoxDecoration(color: Color(0x08000000)),
            child: Column(
              children: [
                Container(
                    // height: 40.0,
                    decoration: BoxDecoration(color: Colors.white),
                    padding: EdgeInsets.only(
                        left: 13.0, right: 12.0, top: 10.0, bottom: 10.0),
                    child: Row(children: [
                      const Text('选择您要查看的课程',
                          style: TextStyle(
                            fontSize: 17,
                          )),
                      Padding(padding: EdgeInsets.only(left: 15)),
                      //搜索框
                      Expanded(
                          child: Container(
                              height: 34.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(17.0),
                                  color: Colors.grey[200]),
                              child: TextField(
                                  onSubmitted: (String value) {
                                    setState(() {
                                      _searchword = value;
                                    });
                                  },
                                  textInputAction: TextInputAction.search,
                                  controller: _controller,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '输入课程名查询',
                                    hintStyle: TextStyle(fontSize: 14.0),
                                    contentPadding: EdgeInsets.only(top: 0.2),
                                    prefixIcon: Icon(Icons.search,
                                        size: 18.0, color: Colors.grey),
                                    suffixIcon: GestureDetector(
                                      //触摸控件
                                      onTap: () {
                                        _controller?.clear(); //清除输入框控制器
                                        setState(() {
                                          _searchword = '';
                                        });
                                      },
                                      child: Icon(
                                        //后置图标
                                        Icons.clear,
                                        size: 18.0,
                                        color: _searchword == ''
                                            ? Colors.grey[200]
                                            : Colors.grey, //去图标的技巧:当空时设置为没颜色
                                      ),
                                    ),
                                  ))))
                    ])),

                Padding(padding: EdgeInsets.only(top: 10)),

                //展示课程栏目
                _searchword == ''
                    ? Expanded(
                        child: ListView(
                            children: widget.curCourseList
                                .map((item) => InfoItemWidget(item, isPortraitKind: widget.isPortraitKind,))
                                .toList()))
                    : Expanded(
                        child: ListView(
                            children: widget.curCourseList
                                .where((item) =>
                                    item.courseName.startsWith(_searchword))
                                .map((e) => InfoItemWidget(e, isPortraitKind: widget.isPortraitKind))
                                .toList()))
              ],
            )));
  }
}

//第一版——PaginatedData布局（已弃用）/  可用于查看评分结果
/* SingleChildScrollView(
              child: Column(
                children: [
                  PaginatedDataTable(
                    source: _sourceData,
                    header: Text('这里可以是搜索框'),
                    columns: [
                      DataColumn(label: Text('课程名称')),
                      DataColumn(label: Text('课程号')),
                      DataColumn(label: Text('授课教师')),
                      DataColumn(label: Text('学期')),
                      DataColumn(label: Text('操作')),
                      //操作有 评价 | 查看两种， 使用按钮
                    ],
                  )
                ],
              ),
            ) */
/* class SourceData extends DataTableSource {
  int _selectCount = 0; //当前选中的行数
  final List<TeachingItemData> _sourceData = dataList;
  bool get isRowCountApproximate => false;
  int get rowCount => _sourceData.length;

  int get selectedRowCount => _selectCount;

  DataRow getRow(int index) => DataRow.byIndex(index: index, cells: [
        DataCell(Text(_sourceData[index].courseName)),
        DataCell(Text(_sourceData[index].courseID)),
        DataCell(Text(_sourceData[index].teacherName)),
        DataCell(Text(_sourceData[index].semester)),
        DataCell(ElevatedButton(
          child: _sourceData[index].isSubmit ? const Text('查看') : const Text('评价'),
          onPressed: () {
            // Navigator.pushReplacementNamed(context, Routes.login);
          },
        ))
      ]);
} */