
// import 'package:conditional_questions/conditional_questions.dart';
import 'package:edu_rating_app/pages/admin/admin_home.dart';
import 'package:edu_rating_app/pages/home/index.dart';
import 'package:edu_rating_app/pages/login.dart';
import 'package:edu_rating_app/routes.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';


class Application extends StatelessWidget {
  const Application({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      final router= FluroRouter();
      Routes.confRoutes(router);
      return MaterialApp(
        // home: LoginPage(),
        home: HomePage(),
        // home: adminHomePage(),
        onGenerateRoute: router.generator,
    );
}
}