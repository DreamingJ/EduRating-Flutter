import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:edu_rating_app/pages/userIDProvider.dart';
import 'package:edu_rating_app/pages/globalUserInfo.dart';
import 'package:edu_rating_app/routes.dart';
import 'package:edu_rating_app/config.dart';
import 'package:edu_rating_app/utils/common_toast.dart';
import 'package:edu_rating_app/utils/string_is_empty.dart';
import 'package:flutter/Material.dart';

class adminLoginPage extends StatefulWidget {
  const adminLoginPage({Key? key}) : super(key: key);

  @override
  State<adminLoginPage> createState() => _adminLoginPageState();
}

//1.创建controller 2.在Textfiled注册controller 3.handle函数

class _adminLoginPageState extends State<adminLoginPage> {
  bool showPwd = false;
  var userIDController = TextEditingController();
  var passwordController = TextEditingController();
  //信息：id、密码——姓名、身份； 参数-id，去取出另外的信息： pre页用、info页用
  //前端本地版——在本地List查询输入的id，核对是否有用户，核对密码是否一致，routes传入id参数
  _loginHandle() async {
    var userID = userIDController.text;
    var password = passwordController.text;

    if (stringIsEmpty(userID) || stringIsEmpty(password)) {
      CommonToast.showToast('账号或密码不能为空！');
      return;
    }
    var bytes = utf8.encode(password);
    var digest = md5.convert(bytes).toString();
    //接口地址
    //post参数
    const url = Config.BaseUrl+'/admin/login';
    //注意这里是loginID
    Map<String, String> params = {'adminID': userID, 'adminPwd': digest};
    //必须先把map转成formdata，才能过dio，否则error400
    var formdata = FormData.fromMap(params);
    try{
    //response
    var res = await Dio().post(url,data: formdata);
    //转为json格式
    var resString = json.decode(res.toString());

    String code = resString['code'];
    String msg = resString['msg'];
    
    if (code == '0') {
      Navigator.pushReplacementNamed(context, Routes.adminhome);
      CommonToast.showToast("登录成功！");
    }
    else{
      CommonToast.showToast("账号或密码错误！");
    }
    }
    catch(e){
      print(e);
      CommonToast.showToast("登录时错误，请重试");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("鸿雁授课质量评价系统"),
          backgroundColor: Colors.green,//设置标题栏的背景颜色
          centerTitle: true,
        ),
        body: SafeArea(
            minimum: EdgeInsets.all(30),
            child: ListView(
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.only(left: 30, top: 26, right: 30, bottom: 20),
                  child: Text(
                    "欢迎管理员，请先进行认证!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                TextField(
                  controller: userIDController,
                  decoration: InputDecoration(
                    labelText: "管理员帐号",
                    hintText: "请输入管理员帐号",
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                TextField(
                  controller: passwordController,
                  obscureText: !showPwd,
                  decoration: InputDecoration(
                      labelText: "密码",
                      hintText: "请输入密码",
                      suffixIcon: IconButton(
                        icon: Icon(
                            showPwd ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            showPwd = !showPwd;
                          });
                        },
                      )),
                ),
                Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 5)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, Routes.login);
                      },
                      child: const Text(
                        "返回用户登录",
                        style: TextStyle(color: Colors.green),
                      ),
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      child: const Text("登录"),
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
                      onPressed: () async {
                        //后端接口改写， 传回的应该是这个user所有信息，  状态管理能否用json传？
                        _loginHandle();
                      }),
                )
              ],
            )));
  }
}
