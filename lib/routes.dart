import 'package:edu_rating_app/pages/home/index.dart';
import 'package:edu_rating_app/pages/home/tab_info/info_index.dart';
import 'package:edu_rating_app/pages/home/tab_info/portrait_info.dart';
import 'package:edu_rating_app/pages/home/tab_info/quality_info.dart';
import 'package:edu_rating_app/pages/home/tab_study/study_evaluate.dart';
import 'package:edu_rating_app/pages/home/tab_study/study_index.dart';
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
  static String login='/login';
  static String register='/register';
  static String teachIndex='/teachIndex';
  static String studyIndex='/studyIndex';
  static String infoIndex='/infoIndex';
  static String teachEval='/teachEval';
  static String studyEval='/studyEval';
  static String qualityInfo='/qualityInfo';
  static String portraitInfo='/portraitInfo';

  //2。路由处理函数
  static Handler _homeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      // String userID = params['userID']?.first;
    // return HomePage(userID: userID,);
    return HomePage();
  });

  static Handler _loginHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return LoginPage();
  });

  static Handler _registerHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return RegisterPage();
  });

  static Handler _teachIndexHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    //   String userID = params['userID']?.first;
    // return TabTeaching(userID: userID,);
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
    return TeachingEvaluate(courseID: courseID,);
  });

  static Handler _studyEvalHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      String courseID = params['courseID']?.first;
    return StudyEvaluate(courseID: courseID,);
  });

  static Handler _qualityInfoHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      String courseID = params['courseID']?.first;
    return QualityInfo(courseID: courseID,);
  });

  static Handler _portraitInfoHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      String courseID = params['courseID']?.first;
    return PortraitInfo(courseID: courseID,);
  });

  //3.建立关联
  static void confRoutes(FluroRouter router){
    //无效url
    router.notFoundHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      return const NotFoundPage();
    });

    router.define(home, handler: _homeHandler);
    router.define(login, handler: _loginHandler);
    router.define(register, handler: _registerHandler);
    router.define(teachIndex, handler: _teachIndexHandler);
    router.define(studyIndex, handler: _studyIndexHandler);
    router.define(infoIndex, handler: _infoIndexHandler);
    router.define(teachEval, handler: _teachEvalHandler);
    router.define(studyEval, handler: _studyEvalHandler);
    router.define(qualityInfo, handler: _qualityInfoHandler);
    router.define(portraitInfo, handler: _portraitInfoHandler);
  }
}