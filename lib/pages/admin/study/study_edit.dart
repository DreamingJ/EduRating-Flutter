
import 'package:cry/cry_button.dart';
import 'package:cry/form1/cry_input.dart';
import 'package:edu_rating_app/models/study_model_admin.dart';
import 'package:edu_rating_app/pages/admin/api/study_api.dart';
import 'package:edu_rating_app/pages/admin/api/teach_api.dart';
import 'package:edu_rating_app/utils/common_toast.dart';
import 'package:flutter/Material.dart';

class StudyEdit extends StatefulWidget {
  final StudyModel? teachModel;

  const StudyEdit({Key? key, this.teachModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PersonEditState();
  }
}

class PersonEditState extends State<StudyEdit> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  StudyModel? _teachModel = StudyModel();

  @override
  void initState() {
    super.initState();
    if (widget.teachModel != null) {
      _teachModel = widget.teachModel;
    }
  }

  @override
  Widget build(BuildContext context) {
    var form = Form(
      key: formKey,
      child: Wrap(
        children: <Widget>[
          CryInput(
            value: _teachModel!.courseName,
            label: "课程名",
            onSaved: (v) {
              _teachModel!.courseName = v;
            },
            validator: (v) {
              return v!.isEmpty ? "此项未填" : null;
            },
          ),
          CryInput(
            value: _teachModel!.courseID,
            label: "课程ID",
            onSaved: (v) {
              _teachModel!.courseID = v;
            },
            validator: (v) {
              return v!.isEmpty ? "此项未填" : null;
            },
          ),
          CryInput(
            value: _teachModel!.userID,
            label: "评学人ID",
            onSaved: (v) {
              _teachModel!.userID = v;
            },
            validator: (v) {
              return v!.isEmpty ? "此项未填" : null;
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
            StudyApi.saveOrUpdate(_teachModel!.toMap()).then((res) {
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
        title: Text(widget.teachModel == null ? "添加用户" : "修改信息"),
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