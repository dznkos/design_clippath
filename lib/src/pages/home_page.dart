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
      body: Container(
        
      ),
      floatingActionButton: _crearFloatButton(context),
          );
        }
      
        Widget _crearFloatButton(BuildContext context) {
          return FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.cyan,
            onPressed: () {
              Navigator.pushNamed(context, 'producto');
            },
            );

        }
}