
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

      if ( email.contains('@') & email.contains('.') ){
        sink.add(email);
      }else{
        sink.addError('Email debe ser valido');
      }
      
    },
  );

}