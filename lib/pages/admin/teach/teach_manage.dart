
import 'package:cry/cry_button.dart';
import 'package:cry/model/order_item_model.dart';
import 'package:cry/model/page_model.dart';
import 'package:cry/model/request_body_api.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:edu_rating_app/models/teach_model_admin.dart';
import 'package:edu_rating_app/pages/admin/api/teach_api.dart';
import 'package:edu_rating_app/pages/admin/teach/teach_edit.dart';
import 'package:edu_rating_app/utils/common_toast.dart';
import 'package:flutter/Material.dart';

class TeachManagePage extends StatefulWidget {
  const TeachManagePage({Key? key}) : super(key: key);

  @override
  State<TeachManagePage> createState() => _TeachManagePageState();
}

class _TeachManagePageState extends State<TeachManagePage> {
  //管理当前widget的state
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  SourceData myDS = SourceData();
  TeachModel formData = TeachModel();
  int rowsPerPage = 8;

  //按钮的响应方法
  _reset() {
    formData = TeachModel();
    formKey.currentState!.reset();
    myDS.requestBodyApi.params = formData.toMap();
    myDS.loadData();
  }

  _query() {
    formKey.currentState?.save();
    myDS.requestBodyApi.params = formData.toMap();
    myDS.loadData();
  }

  _edit({TeachModel? teachModel}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: TeachEdit(
          teachModel: teachModel,
        ),
      ),
    ).then((v) {
      if (v != null) {
        _query();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    myDS.context = context;
    myDS.state = this;
    myDS.page.size = rowsPerPage;
    myDS.addListener(() {
      if (mounted) setState(() {});
    });
    WidgetsBinding.instance!.addPostFrameCallback((c) {
      _query();
    });
  }

  @override
  Widget build(BuildContext context) {
    var form = Form(
      key: formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width: 90,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "课程号",
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: formData.courseID),
              onSaved: (v) {
                formData.courseID = v;
              },
            ),
          ),
          Container(
            width: 90,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "评教人ID",
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: formData.userID),
              onSaved: (v) {
                formData.userID = v;
              },
            ),
          ),
          
          CryButton(
              label: "查询", iconData: Icons.search, onPressed: () => _query()),
        ],
      ),
    );

    var buttonBar = Padding(
      padding: EdgeInsets.only(
        left: 15,
        top: 10,
      ),
      child: Wrap(
        spacing: 6.0,
        runSpacing: 8.0,
        children: <Widget>[
          CryButton(
              label: "重置", iconData: Icons.refresh, onPressed: () => _reset()),
          CryButton(label: "添加", iconData: Icons.add, onPressed: () => _edit()),
          CryButton(
            label: "修改",
            iconData: Icons.edit,
            onPressed: myDS.selectedCount != 1
                ? null
                : () {
                    if (myDS.selectedRowCount != 1) {
                      return;
                    }
                    TeachModel teachModel = myDS.dataList.firstWhere((v) {
                      return v.selected!;
                    });
                    _edit(teachModel: teachModel);
                  },
          ),
          CryButton(
            label: "删除",
            iconData: Icons.delete,
            onPressed: myDS.selectedCount < 1
                ? null
                : () {
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("提示"),
                          content: Text("确认删除?"),
                          actions: <Widget>[
                            TextButton(
                              child: Text("取消"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text("确定"),
                              onPressed: () async {
                                Navigator.of(context).pop();
                                List ids = myDS.dataList.where((v) {
                                  return v.selected!;
                                }).map<int?>((v) {
                                  return v.tID;
                                }).toList();
                                var result = await TeachApi.removeByIds(ids);
            //                     TeachApi.saveOrUpdate(teachModel!.toMap()).then((res) {
            //   Navigator.pop(context, true);
            //   CommonToast.showToast("保存成功!");
            // });
                                if (result.success) {
                                  _query();
                                  CommonToast.showToast("删除成功！");
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
          ),
        ],
      ),
    );
    // CryButtonBar(

    Scrollbar table = Scrollbar(
      child: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          PaginatedDataTable(
            // header: Text('用户列表'),
            columnSpacing: 26.0,
            rowsPerPage: rowsPerPage,
            // onRowsPerPageChanged: (int? value) {
            //   setState(() {
            //     if (value != null) {
            //       rowsPerPage = value;
            //       myDS.page.size = rowsPerPage;
            //       myDS.loadData();
            //     }
            //   });
            // },
            // availableRowsPerPage: <int>[3,5,6, 8, 10],
            onPageChanged: myDS.onPageChanged,
            columns: const [
              DataColumn(label: Text('课程名')),
              DataColumn(label: Text('评教人ID')),
              DataColumn(label: Text('参评情况')),
              DataColumn(label: Text('查看详情')),
              //操作有 评价 | 查看两种， 使用按钮
            ],
            source: myDS,
          )
        ],
      ),
    );

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          form,
          buttonBar,
          Expanded(
            child: table,
          ),
        ],
      ),
    );
  }
}

class SourceData extends DataTableSource {
  SourceData();

  late _TeachManagePageState state;
  late BuildContext context;
  List<TeachModel> dataList = [];

  int selectedCount = 0; //当前选中的行数
  RequestBodyApi requestBodyApi = RequestBodyApi();
  PageModel page =
      PageModel(orders: [OrderItemModel(column: 'create_time', asc: false)]);
  //要展示信息的list
  // final List<CourseItemData> _sourceData = dataList;

  loadData() async {
    requestBodyApi.page = page;
    // print(requestBodyApi.toString());
    ResponseBodyApi responseBodyApi =
        await TeachApi.page(requestBodyApi.toMap());
    page = PageModel.fromMap(responseBodyApi.data);

    //解析得到返回的的数据表
    dataList = page.records.map((e) {
      TeachModel teachModel = TeachModel.fromMap(e);
      teachModel.selected = false;
      return teachModel;
    }).toList();
    selectedCount = 0;
    notifyListeners();
  }

  onPageChanged(firstRowIndex) {
    page.current = firstRowIndex / page.size + 1;
    loadData();
  }

  @override
  DataRow? getRow(int index) {
    var dataIndex = index - page.size * (page.current - 1);

    if (dataIndex >= dataList.length) {
      return null;
    }
    TeachModel userModel = dataList[dataIndex];

    return DataRow.byIndex(
        index: index,
        selected: userModel.selected!,
        onSelectChanged: (bool? value) {
          userModel.selected = value;
          selectedCount += value! ? 1 : -1;
          notifyListeners();
        },
        cells: [
          DataCell(Text(userModel.courseName ?? '--')),
          
          DataCell(TextButton( onPressed: () {
                //TODO： 弹窗user详细信息
              }, child: Text(userModel.userID ?? '--'),)),
          DataCell(Text(userModel.isSubmit!?'已评':'待评')),
          DataCell(TextButton( onPressed: () {
            Navigator.pushNamed(context, '/teachEval/view?courseID=${userModel.courseID}&courseName=${Uri.encodeComponent(userModel.courseName!)}',);
              }, child: Text('详情'),)),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => dataList.length;
  @override
  int get selectedRowCount => selectedCount;
}
