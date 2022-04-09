

import 'package:edu_rating_app/routes.dart';
import 'package:flutter/material.dart';

class PageContent extends StatelessWidget {

  final String name;

  const PageContent({ Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('当前页面：$name'),),
        body: 
        ListView(children: [
          ElevatedButton(onPressed: (){
            Navigator.pushNamed(context, Routes.home);
          },
          child: Text(Routes.home)
          ),
          ElevatedButton(onPressed: (){
            Navigator.pushNamedAndRemoveUntil(context, Routes.login, ModalRoute.withName(Routes.login));
          },
          child: Text("EXIT: "+Routes.login)
          ),
          ElevatedButton(onPressed: (){
            Navigator.pushNamed(context, Routes.teachIndex);
          },
          child: Text(Routes.teachIndex)
          ),
          ElevatedButton(onPressed: (){
            Navigator.pushNamed(context, Routes.teachEval);
          },
          child: Text(Routes.teachEval)
          ),
        ],)
    );
  }
}