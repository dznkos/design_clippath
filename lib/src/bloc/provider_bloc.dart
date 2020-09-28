
import 'package:flutter/material.dart';
import 'package:form_val/src/bloc/login_bloc.dart';

class Provider extends InheritedWidget{

  
  static Provider _instancia;

  // Singleton para provider
  factory Provider({ Key key, Widget child}){

    if( _instancia == null){
      _instancia = new Provider._internal(key: key, child: child);
    }
    return _instancia;
  }

  Provider._internal({ Key key, Widget child})
    : super (key: key, child: child);

  // Unica instancia inicializada
  final loginBloc = LoginBloc();

  //Provider({ Key key, Widget child})
  //  : super (key: key, child: child);


  // InheritedWidget
  //-  Configuracion
  @override
  bool updateShouldNotify(InheritedWidget oldWidget ) => true;

 // InheritedWidget
 // - proveedor de loginbloc a contexto requerido
  static LoginBloc of (BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).loginBloc;
  }
}