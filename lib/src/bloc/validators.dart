
import 'dart:async';

class Validators {

  final validarPassword = StreamTransformer<String,String>.fromHandlers(
    handleData: ( password, sink) {

      if ( password.length >= 6){
        sink.add(password);
      }else{
        sink.addError('Password debe tener minimo 6 caracteres');
      }

    },
  );

  final validarEmail = StreamTransformer<String,String>.fromHandlers(
    handleData: ( email, sink) {

      Pattern pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
      RegExp regExp = new RegExp(pattern);

      if ( regExp.hasMatch( email ) ){
        sink.add(email);
      }else{
        sink.addError('Email debe ser valido');
      }
      
    },
  );

}