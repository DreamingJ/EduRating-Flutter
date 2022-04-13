import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edu_rating_app/config.dart';
import 'package:edu_rating_app/routes.dart';
import 'package:edu_rating_app/utils/common_toast.dart';
// import 'package:edu_rating_app/utils/dio_http.dart';
import 'package:edu_rating_app/utils/string_is_empty.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var usernameController = TextEditingController();
  var pwdController = TextEditingController();
  var repwdController = TextEditingController();

  _registerHandler() async {
    var username = usernameController.text;
    var pwd = pwdController.text;
    var repwd = repwdController.text;
    if (pwd != repwd) {
      CommonToast.showToast('两次输入的密码不一样！');
      return;
    }
    if (stringIsEmpty(username) || stringIsEmpty(pwd) || stringIsEmpty(repwd)) {
      CommonToast.showToast('用户名或密码不能为空！');
      return;
    }
    
    //接口地址
    const url = Config.BaseUrl+'/user/register';
    //post参数
    var params = FormData.fromMap({"userID": username, "userPwd": pwd});
    //response
    var res = await Dio().post(url, data: params);
    //转为json格式
    var resString = json.decode(res.toString());

    String code = resString['code'];
    String msg = resString['msg'];
    CommonToast.showToast(msg);
    if (code=='0') {
      Navigator.pushReplacementNamed(context, Routes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("账号激活"),
          centerTitle: true,
        ),
        body: SafeArea(
            minimum: EdgeInsets.all(30),
            child: ListView(
              children: <Widget>[
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: "学工号",
                    hintText: "请输入学工号",
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                TextField(
                  controller: pwdController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "密码",
                    hintText: "请输入密码",
                  ),
                ),
                Padding(padding: EdgeInsets.all(3)),
                TextField(
                  controller: repwdController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "确认密码",
                    hintText: "再次输入密码",
                  ),
                ),
                Padding(padding: EdgeInsets.all(3)),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      child: const Text("确认激活"),
                      onPressed: () async {
                        _registerHandler();
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('账号已激活,'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, Routes.login);
                      },
                      child: const Text(
                        "去登陆",
                        //style: TextStyle(decoration: TextDecoration.underline),
                      ),
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                      ),
                    )
                  ],
                ),
              ],
            )));
  }
}
