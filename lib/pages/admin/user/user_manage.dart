import 'package:cry/cry_button.dart';
import 'package:cry/model/order_item_model.dart';
import 'package:cry/model/page_model.dart';
import 'package:cry/model/request_body_api.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:cry/vo/select_option_vo.dart';
import 'package:edu_rating_app/models/UserModel.dart';
import 'package:edu_rating_app/pages/admin/api/person_api.dart';
import 'package:edu_rating_app/pages/admin/user/user_edit.dart';
import 'package:edu_rating_app/utils/common_toast.dart';
import 'package:flutter/Material.dart';

class UserManagePage extends StatefulWidget {
  const UserManagePage({Key? key}) : super(key: key);

  @override
  State<UserManagePage> createState() => _UserManagePageState();
}

class _UserManagePageState extends State<UserManagePage> {
  //管理当前widget的state
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  SourceData myDS = SourceData();
  UserModel formData = UserModel();
  int rowsPerPage = 8;

  //按钮的响应方法
  _reset() {
    formData = UserModel();
    formKey.currentState!.reset();
    myDS.requestBodyApi.params = formData.toMap();
    myDS.loadData();
  }

  _query() {
    formKey.currentState?.save();
    myDS.requestBodyApi.params = formData.toMap();
    myDS.loadData();
  }

  _edit({UserModel? userModel}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: PersonEdit(
          userModel: userModel,
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
                hintText: "姓名",
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: formData.userName),
              onSaved: (v) {
                formData.userName = v;
              },
            ),
          ),
          Container(
            width: 130,
            child: DropdownButtonFormField<String>(
              hint: Text("选择学院"),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(),
              ),
              value: formData.deptName,
              items: [
                SelectOptionVO(value: "计算机学院", label: "计算机学院"),
                SelectOptionVO(value: "信通学院", label: "信通学院"),
                SelectOptionVO(value: "人文学院", label: "人文学院"),
                SelectOptionVO(value: "理学院", label: "理学院"),
                SelectOptionVO(value: "经管学院", label: "经管学院"),
                SelectOptionVO(value: "自动化学院", label: "自动化学院"),
              ].map((v) {
                return DropdownMenuItem<String>(
                  value: v.value as String?,
                  child: Text(v.label!),
                );
              }).toList(),
              onChanged: (v) {
                formData.deptName = v;
              },
              onSaved: (v) {
                formData.deptName = v;
              },
            ),
            // CrySelect(

            //   label: "学院",
            //   value: formData.deptName,
            //   dataList: [
            //     SelectOptionVO(value: "计算机学院", label: "计算机学院"),
            //     SelectOptionVO(value: "信通学院", label: "信通学院"),
            //     SelectOptionVO(value: "人文学院", label: "人文学院"),
            //     SelectOptionVO(value: "理学院", label: "理学院"),
            //     SelectOptionVO(value: "经管学院", label: "经管学院"),
            //     SelectOptionVO(value: "自动化学院", label: "自动化学院"),
            //   ],
            //   onSaved: (v) {
            //     formData.deptName = v;
            //   },
            // ),
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
                    UserModel userModel = myDS.dataList.firstWhere((v) {
                      return v.selected!;
                    });
                    _edit(userModel: userModel);
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
                                }).map<String?>((v) {
                                  return v.userID;
                                }).toList();
                                var result = await PersonApi.removeByIds(ids);
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
              DataColumn(label: Text('姓名')),
              DataColumn(label: Text('学工号')),
              DataColumn(label: Text('身份')),
              DataColumn(label: Text('学院')),
              //操作有 评价 | 查看两种， 使用按钮
            ],
            source: myDS,
          )
        ],
      ),
    );

    // var table = ListView(children:
    //   myDS.dataList.map((e){
    //     return Row(children: [
    //       Text(e.userName?? '--'),
    //       Text(e.userID?? '--'),
    //       Text(e.status?? '--'),
    //       Text(e.deptName?? '--'),

    //     ],);
    //   }).toList());

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

  late _UserManagePageState state;
  late BuildContext context;
  List<UserModel> dataList = [];

  int selectedCount = 0; //当前选中的行数
  RequestBodyApi requestBodyApi = RequestBodyApi();
  PageModel page =
      PageModel(orders: [OrderItemModel(column: 'create_time', asc: false)]);
  //要展示信息的list
  // final List<CourseItemData> _sourceData = dataList;

  loadData() async {
    requestBodyApi.page = page;
    //这一步返回的值是null，因此出错跳过
    ResponseBodyApi responseBodyApi =
        await PersonApi.page(requestBodyApi.toMap());
    page = PageModel.fromMap(responseBodyApi.data);

    //解析得到返回的的数据表
    dataList = page.records.map((e) {
      UserModel userModel = UserModel.fromMap(e);
      userModel.selected = false;
      return userModel;
    }).toList();
    selectedCount = 0;
    //TODO: notify的机制和输入输出
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
    UserModel userModel = dataList[dataIndex];

    return DataRow.byIndex(
        index: index,
        selected: userModel.selected!,
        onSelectChanged: (bool? value) {
          userModel.selected = value;
          selectedCount += value! ? 1 : -1;
          notifyListeners();
        },
        cells: [
          DataCell(Text(userModel.userName ?? '--')),
          DataCell(Text(userModel.userID ?? '--')),
          DataCell(Text(userModel.status ?? '--')),
          DataCell(Text(userModel.deptName ?? '--')),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => dataList.length;
  @override
  int get selectedRowCount => selectedCount;
}
