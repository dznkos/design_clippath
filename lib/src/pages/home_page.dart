import 'package:flutter/material.dart';

import 'package:form_val/src/bloc/provider_bloc.dart';

class HomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final login = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity,),
          Text('Informacion:'),
          Text('Usuario: ${login.email}'),
          Text('Password: ${login.password}'),
        ],
      ),
    );
  }
}