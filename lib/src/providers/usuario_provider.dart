
import 'dart:convert';

import 'package:http/http.dart' as http;

class UsuarioProvider {

  final String _firebaseToken = 'AIzaSyAea7QIlQoZWh7JwF6KwlIrOLjulsYMUbw';


  Future nuevoUsuario( String email, String password ) async{

    final authData = {
      'email'    : email,
      'password' : password,
      'returnSecureToken' : true 
    };

    final resp = await http.post(
                   'https://identitytoolkit.googleapis.com/v1/accounts:signInWithCustomToken?key=$_firebaseToken', 
                   body: json.encode( authData ) 
                 );
    
    Map<String,dynamic> decodeResp = json.decode( resp.body );
  
    print( decodeResp );

    if ( decodeResp.containsKey('idToken') ){
      //salvar token en el login
      return { 'ok': true, 'token': decodeResp['idToken'] };
    }else {
      return { 'ok': false, 'mensaje': decodeResp['error']['message'] };
    }
  }

}