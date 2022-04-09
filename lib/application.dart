
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
      return ChangeNotifierProvider(
      create: (context) => UserIDProvider(), child:MaterialApp(
        // home: LoginPage(),
        home: HomePage(),
        onGenerateRoute: router.generator,
    ));
  }
}