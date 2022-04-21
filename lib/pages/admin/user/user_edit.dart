
import 'package:cry/cry_button.dart';
import 'package:cry/form1/cry_input.dart';
import 'package:cry/form1/cry_select.dart';
import 'package:cry/vo/select_option_vo.dart';
import 'package:edu_rating_app/models/UserModel.dart';
import 'package:edu_rating_app/pages/admin/api/person_api.dart';
import 'package:edu_rating_app/utils/common_toast.dart';
import 'package:flutter/Material.dart';

class PersonEdit extends StatefulWidget {
  final UserModel? userModel;

  const PersonEdit({Key? key, this.userModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PersonEditState();
  }
}

class PersonEditState extends State<PersonEdit> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UserModel? _userModel = UserModel();

  @override
  void initState() {
    super.initState();
    if (widget.userModel != null) {
      _userModel = widget.userModel;
    }
  }

  @override
  Widget build(BuildContext context) {
    var form = Form(
      key: formKey,
      child: Wrap(
        children: <Widget>[
          CryInput(
            value: _userModel!.userName,
            label: "姓名",
            onSaved: (v) {
              _userModel!.userName = v;
            },
            validator: (v) {
              return v!.isEmpty ? "此项未填" : null;
            },
          ),
          CryInput(
            value: _userModel!.userID,
            label: "学工号",
            onSaved: (v) {
              _userModel!.userID = v;
            },
            validator: (v) {
              return v!.isEmpty ? "此项未填" : null;
            },
          ),
          CrySelect(
            label: "身份",
            value: _userModel!.status,
            dataList:  [
              SelectOptionVO(value: "学生", label: "学生"),
              SelectOptionVO(value: "教师", label: "教师"),
              SelectOptionVO(value: "领导", label: "领导"),
              SelectOptionVO(value: "督导专家", label: "督导专家"),
            ],
            onSaved: (v) {
              _userModel!.status = v;
            },
          ),
          CrySelect(
            label: "学院",
            value: _userModel!.deptName,
            dataList:  [
              SelectOptionVO(value: "计算机学院", label: "计算机学院"),
              SelectOptionVO(value: "信通学院", label: "信通学院"),
              SelectOptionVO(value: "人文学院", label: "人文学院"),
              SelectOptionVO(value: "理学院", label: "理学院"),
              SelectOptionVO(value: "经管学院", label: "经管学院"),
              SelectOptionVO(value: "自动化学院", label: "自动化学院"),
            ],
            onSaved: (v) {
              _userModel!.deptName = v;
            },
          ),
        ],
      ),
    );
    var buttonBar = ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        CryButton(
          label: "保存",
          iconData: Icons.save,
          onPressed: () {
            FormState form = formKey.currentState!;
            if (!form.validate()) {
              return;
            }
            form.save();
            PersonApi.saveOrUpdate(_userModel!.toMap()).then((res) {
              Navigator.pop(context, true);
              CommonToast.showToast("保存成功!");
            });
          },
        ),
        CryButton(
          label: "取消",
          iconData: Icons.cancel,
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
    var result = Scaffold(
      appBar: AppBar(
        title: Text(widget.userModel == null ? "添加用户" : "修改信息"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            form,
          ],
        ),
      ),
      bottomNavigationBar: buttonBar,
    );
    return SizedBox(
      width: 650,
      // height: isDisplayDesktop(context) ? 350 : 500,
      height: 500,
      child: result,
    );
  }
}