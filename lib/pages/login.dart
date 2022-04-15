import 'dart:convert';

// import 'package:conditional_questions/conditional_questions.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
// import 'package:edu_rating_app/data/user_list.dart';
// import 'package:edu_rating_app/pages/home/index.dart';
// import 'package:edu_rating_app/pages/home/tab_teaching/teaching_pre.dart';
import 'package:edu_rating_app/pages/userIDProvider.dart';
import 'package:edu_rating_app/pages/globalUserInfo.dart';
import 'package:edu_rating_app/routes.dart';
import 'package:edu_rating_app/config.dart';
import 'package:flutter/Material.dart';
import 'package:provider/provider.dart';
// import 'package:flutter/material.dart';

import '../utils/common_toast.dart';
// import '../utils/dio_http.dart';
import '../utils/string_is_empty.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

//1.创建controller 2.在Textfiled注册controller 3.handle函数

class _LoginPageState extends State<LoginPage> {
  bool showPwd = false;
  var userIDController = TextEditingController();
  var passwordController = TextEditingController();
  //信息：id、密码——姓名、身份； 参数-id，去取出另外的信息： pre页用、info页用
  //前端本地版——在本地List查询输入的id，核对是否有用户，核对密码是否一致，routes传入id参数
  _loginHandle(dynamic userInfoProv) async {
    var userID = userIDController.text;
    var password = passwordController.text;

    if (stringIsEmpty(userID) || stringIsEmpty(password)) {
      CommonToast.showToast('用户名或密码不能为空！');
      return;
    }
    var bytes = utf8.encode(password);
    var digest = md5.convert(bytes).toString();
    //接口地址
    //post参数
    const url = Config.BaseUrl+'/user/login';
    Map<String, String> params = {'userID': userID, 'userPwd': digest};
    //必须先把map转成formdata，才能过dio，否则error400
    var formdata = FormData.fromMap(params);
    try{
    //response
    var res = await Dio().post(url,data: formdata);
    //转为json格式
    var resString = json.decode(res.toString());

    String code = resString['code'];
    String msg = resString['msg'];
    CommonToast.showToast(msg);
    //成功时就把userInfo存到状态管理
    if (code == '0') {
      var resData = resString['data'];
      // userInfoProv.change(resData['userID'], resData['userName'],resData['status'],resData['deptName']);
      GlobalUserInfo.change(resData['userID'], resData['userName'],resData['status'],resData['deptName']);
      Navigator.pushReplacementNamed(context, Routes.home);
    }
    }
    catch(e){
      print(e);
      CommonToast.showToast("登录时错误，请重试");
    }
  }

  @override
  Widget build(BuildContext context) {
    //consumer
    var userInfoProv = Provider.of<UserInfoProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("鸿雁授课质量评价系统"),
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
                    "欢迎您，请先进行身份认证!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                TextField(
                  controller: userIDController,
                  decoration: InputDecoration(
                    labelText: "学工号",
                    hintText: "请输入学工号",
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
                            context, Routes.register);
                      },
                      child: const Text(
                        "账号激活",
                        //style: TextStyle(decoration: TextDecoration.underline),
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
                      onPressed: () async {
                        //后端接口改写， 传回的应该是这个user所有信息，  状态管理能否用json传？
                        _loginHandle(userInfoProv);
                        

                        // String inputuserID = userIDController.text;
                        // String inputpwd = passwordController.text;
                        // if (stringIsEmpty(inputuserID) ||
                        //     stringIsEmpty(inputpwd)) {
                        //   CommonToast.showToast('学工号或密码不能为空！');
                        //   return;
                        // }
                        // bool flag =false;

                        // for (var user in userList) {
                        //   if (user.userID == inputuserID) {
                        //     if (user.userPwd == inputpwd) {
                        //       flag=true;
                        //       //更新userID
                        //       userIDProv.change(inputuserID);
                        //       Navigator.pushReplacementNamed(
                        //         context,
                        //         Routes.home
                        //       );
                        //     } else {
                        //       CommonToast.showToast('密码错误！');
                        //       return;
                        //     }
                        //   }
                        // }
                        // if(flag==false){
                        // CommonToast.showToast('该用户不存在！');
                        // return;
                        // }
                      }),
                )
              ],
            )));
  }
}
