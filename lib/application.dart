
// import 'package:conditional_questions/conditional_questions.dart';
import 'package:edu_rating_app/pages/home/index.dart';
import 'package:edu_rating_app/pages/login.dart';
import 'package:edu_rating_app/routes.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/userIDProvider.dart';

class Application extends StatelessWidget {
  const Application({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      final router= FluroRouter();
      Routes.confRoutes(router);
      return MultiProvider(
      // create: (context) => UserInfoProvider(), 
      providers: [
        ChangeNotifierProvider(create:(context) => UserInfoProvider()),
        //TODO : 把库文件搬过来，只在这里注册provider，在所有地方共享  or使用全局变量
        // ChangeNotifierProvider(create:(context) => QuestionProvider()),

      ],
      child:MaterialApp(
        // home: LoginPage(),
        home: HomePage(),
        onGenerateRoute: router.generator,
    ));
  }
}