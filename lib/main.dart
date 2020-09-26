import 'package:flutter/material.dart';
import 'package:form_val/src/bloc/provider_bloc.dart';

import 'package:form_val/src/pages/home_page.dart';
import 'package:form_val/src/pages/login_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: {
          'login' : (BuildContext context) => LoginPage(),
          'home' : (BuildContext context) => HomePage(),
        },
      ),
    );
  }
}