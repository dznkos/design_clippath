import 'package:flutter/material.dart';
import 'package:form_val/src/bloc/provider_bloc.dart';

import 'package:form_val/src/pages/home_page.dart';
import 'package:form_val/src/pages/login_page.dart';
import 'package:form_val/src/pages/producto_page.dart';
import 'package:form_val/src/pages/registro_page.dart';

import 'package:form_val/src/preferencias_usuario/preferencias_usuario.dart';
 
void main() async{ 
  
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'registro',
        routes: {
          'login' : (BuildContext context) => LoginPage(),
          'home' : (BuildContext context) => HomePage(),
          'producto' : (BuildContext context) => ProductoPage(),
          'registro' : (BuildContext context) => RegistroPage(),
        },
      ),
    );
  }
}