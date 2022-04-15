
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edu_rating_app/config.dart';
import 'package:edu_rating_app/data/course_List.dart';
import 'package:edu_rating_app/pages/globalUserInfo.dart';
import 'package:edu_rating_app/widgets/course_item_wigdet.dart';
import 'package:flutter/material.dart';


class TabTeaching extends StatefulWidget {
  // final String userID;
  List<CourseItemData> curCourseList=[]; //要渲染的课程列表
  final String inputValue=""; //搜索框值

  TabTeaching({
    Key? key,
    // required this.userID,
  }) : super(key: key);

  @override
  State<TabTeaching> createState() => _TabTeachingState();
}

class _TabTeachingState extends State<TabTeaching> {
  String _searchword = '';
  TextEditingController? _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.inputValue);
    super.initState();
    // widget.curCourseList=[];
    getTeachEvalItems();
  }

  Future<void> getTeachEvalItems() async{
    Map<String, String> params = {'userID': GlobalUserInfo.userID};
    var res = await Dio().get(Config.BaseUrl+'/teacheval/items',queryParameters: params);
    // var res = await DioHttp.of(context).get('/teacheval/items',params: params);
    //encode是字符串
    
    var resString = jsonEncode(res.data);
    //decode是可迭代数组
    var resJson = json.decode(resString);
    // resString["data"];
    for(var item in resJson){
      CourseItemData curItem = CourseItemData(courseID: item["courseID"],courseName: item["courseName"], teacherName: item["teacherName"], deptID: item["deptName"], semester: item["semester"], isSubmit: item["submit"]);
      widget.curCourseList.add(curItem);
    }
    
    //刷新页面
    setState(() {
      //使用Navigator.push后页面就会重新build
    });
    }

  @override
  Widget build(BuildContext context) {
    //每次重置为空，重新取
    // widget.curCourseList=[];
    // getTeachEvalItems();
    
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.white),
          title: const Text('选择评教栏目'),
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
                      const Text('点击卡片进行评价',
                          style: TextStyle(
                            fontSize: 16,
                          )),
                      Padding(padding: EdgeInsets.only(left: 15)),
                      Expanded(
                          child: Container(
                              height: 34.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(17.0),
                                  color: Colors.grey[200]),
                              child: TextField(
                                //只是改变词然后重新build
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
                                .map((item) => CourseItemWidget(item))
                                .toList()))
                    : Expanded(
                        child: ListView(
                            children: widget.curCourseList
                                .where((item) =>
                                    item.courseName.startsWith(_searchword))
                                .map((e) => CourseItemWidget(e))
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