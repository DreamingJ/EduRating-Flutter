import 'package:edu_rating_app/pages/admin/admin_home.dart';
import 'package:edu_rating_app/pages/admin/admin_login.dart';
import 'package:edu_rating_app/pages/home/index.dart';
import 'package:edu_rating_app/pages/home/tab_info/info_index.dart';
import 'package:edu_rating_app/pages/home/tab_info/portrait_info.dart';
import 'package:edu_rating_app/pages/home/tab_info/quality_info.dart';
import 'package:edu_rating_app/pages/home/tab_study/study_eval_view.dart';
import 'package:edu_rating_app/pages/home/tab_study/study_evaluate.dart';
import 'package:edu_rating_app/pages/home/tab_study/study_index.dart';
import 'package:edu_rating_app/pages/home/tab_teaching/teach_eval_view.dart';
import 'package:edu_rating_app/pages/home/tab_teaching/teaching_evaluate.dart';
import 'package:edu_rating_app/pages/home/tab_teaching/teaching_index.dart';
import 'package:edu_rating_app/pages/not_found_page.dart';
import 'package:edu_rating_app/pages/register.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:edu_rating_app/pages/login.dart';

class Routes{
  //1.路由名称
  static String home='/home';
  static String adminhome='/admin/home';
  static String login='/login';
  static String adminlogin='/adminlogin';
  static String register='/register';
  static String teachIndex='/teachIndex';
  static String studyIndex='/studyIndex';
  static String infoIndex='/infoIndex';
  static String teachEval='/teachEval';
  static String teachEvalView='/teachEval/view';
  static String studyEval='/studyEval';
  static String studyEvalView='/studyEval/view';
  static String qualityInfo='/qualityInfo';
  static String portraitInfo='/portraitInfo';
  //注意URI不用驼峰大写

  //2。路由处理函数
  static Handler _homeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return HomePage();
  });

  static Handler _adminhomeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return adminHomePage();
  });

  static Handler _loginHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return LoginPage();
  });

  static Handler _adminloginHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return adminLoginPage();
  });

  static Handler _registerHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return RegisterPage();
  });

  static Handler _teachIndexHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return TabTeaching();
  });

  static Handler _studyIndexHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return TabStudy();
  });

  static Handler _infoIndexHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      bool isPortraitKind = (params['isPortraitKind']?.first=='true');
    return InfoIndex(isPortraitKind: isPortraitKind,);
  });

  static Handler _teachEvalHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      String courseID = params['courseID']?.first;
      String courseName = params['courseName']?.first;

    return TeachingEvaluate(courseID: courseID, courseName: courseName);
  });

  static Handler _teachEvalViewHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      String courseID = params['courseID']?.first;
      String courseName = params['courseName']?.first;

    return TeachEvalView(courseID: courseID, courseName: courseName);
  });

  static Handler _studyEvalViewHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      String courseID = params['courseID']?.first;
      String courseName = params['courseName']?.first;

    return StudyEvalView(courseID: courseID, courseName: courseName);
  });

  static Handler _studyEvalHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      String courseID = params['courseID']?.first;
      String courseName = params['courseName']?.first;
    return StudyEvaluate(courseID: courseID, courseName: courseName);
  });

  static Handler _qualityInfoHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      String courseID = params['courseID']?.first;
      String courseName = params['courseName']?.first;
      String teacherName = params['teacherName']?.first;
    return QualityInfo(courseID: courseID, courseName: courseName,teacherName:teacherName);
  });

  static Handler _portraitInfoHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      String courseID = params['courseID']?.first;
      String courseName = params['courseName']?.first;
      String teacherName = params['teacherName']?.first;
    return PortraitInfo(courseID: courseID,courseName: courseName,teacherName:teacherName);
  });

  //3.建立关联
  static void confRoutes(FluroRouter router){
    //无效url
    router.notFoundHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      return const NotFoundPage();
    });

    router.define(home, handler: _homeHandler);
    router.define(adminhome, handler: _adminhomeHandler);
    router.define(login, handler: _loginHandler);
    router.define(adminlogin, handler: _adminloginHandler);
    router.define(register, handler: _registerHandler);
    router.define(teachIndex, handler: _teachIndexHandler);
    router.define(studyIndex, handler: _studyIndexHandler);
    router.define(infoIndex, handler: _infoIndexHandler);
    router.define(teachEval, handler: _teachEvalHandler);
    router.define(teachEvalView, handler: _teachEvalViewHandler);
    router.define(studyEvalView, handler: _studyEvalViewHandler);
    router.define(studyEval, handler: _studyEvalHandler);
    router.define(qualityInfo, handler: _qualityInfoHandler);
    router.define(portraitInfo, handler: _portraitInfoHandler);
  }

  //自定义的参数跳转
  // 对参数进行encode，解决参数中有特殊字符，影响fluro路由匹配
//   static Future navigateTo(BuildContext context, String path, {required Map<String, dynamic> params, TransitionType transition = TransitionType.native}) {
//     String query =  "";
//       int index = 0;
//       for (var key in params.keys) {
//         var value = Uri.encodeComponent(params[key]);
//         if (index == 0) {
//           query = "?";
//         } else {
//           query = query + "\&";
//         }
//         query += "$key=$value";
//         index++;
//       }
//     // print('我是navigateTo传递的参数：$query');
//     path = path + query;
//     return Application.router.navigateTo(context, path, transition:transition);
//   }
}