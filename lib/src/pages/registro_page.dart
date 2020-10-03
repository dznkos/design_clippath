import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_val/src/bloc/login_bloc.dart';
import 'package:form_val/src/bloc/provider_bloc.dart';
import 'package:form_val/src/providers/usuario_provider.dart';

class RegistroPage extends StatelessWidget {

  final usuarioProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {

    //final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
              children: [
                _crearFondo(),
                _loginForm(context),

              ]
      ),
    );
  }

  Widget _loginForm(BuildContext context){

    final login = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
            child: Container(
              height: 180.0,

            )
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            padding: EdgeInsets.symmetric(vertical: 50),
            width: size.width * 0.85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0,
                )
              ]
            ),
            child: Column(
              children: [
                Text('Crear cuenta', style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold, color: Colors.blueAccent),),
                SizedBox(height: 15.0,),
                _crearCorreo(login),
                _crearPassword(login),
                _crearBoton(login),
              ],
            ),
          ),
          FlatButton(
            onPressed: ()=> Navigator.pushReplacementNamed(context, 'login'),
            child: Text('¿Ya tienes cuenta?', style: TextStyle(color: Colors.black54, fontSize: 12,),),
          ),

          
          SizedBox(height: 100.0,)
        ],
      ),
    );
  }

  Widget _crearCorreo(LoginBloc bloc){

    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.email, color: Colors.blueAccent),
              hintText: 'example@gmail.com',
              labelText: 'Correo Electronico',
              //counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: bloc.changeEmail            
          ),
        );
      },    
    );
  }

  Widget _crearPassword(LoginBloc bloc){
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (context, snapshot) {
        return Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    icon: Icon(Icons.lock_outline, color: Colors.blueAccent,),
                    labelText: 'Password',
                    counterText: snapshot.data,
                    errorText: snapshot.error,
                ),
                onChanged: bloc.changePassword,
              ),
        );
      }, 
    );
  }

  Widget _crearBoton(LoginBloc bloc){

    return StreamBuilder(
      stream: bloc.formValidateStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
              child: Text('Registrarme'),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
            ),
            elevation: 0.0,
            color: Colors.blueAccent,
            textColor: Colors.white,
            onPressed: snapshot.hasData ? (){ _register(context,bloc); } : null
            
                    );
                  },     
                );
            
                
  }
            
  Widget _crearFondo(){
    return Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 180),
            height: 520.0,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: AlignmentDirectional.topCenter,
                    end: AlignmentDirectional.bottomCenter,
                    stops: [
                      0.1,0.3,0.9,1.1,
                    ],
                    colors: [
                      Colors.blue,
                      Colors.blueAccent,
                      Colors.blue[300],
                      Colors.teal
                    ]
                )
            ),
          ),
          ClipPath(
              clipper: MyClipperStyleOne(),
              child: Container(
                height: 225,
                color: Colors.lightBlue[500],
              )
          ),
          ClipPath(
              clipper: MyClipperStyleOne(),
              child: Container(
                //margin: EdgeInsets.only(top: 480),
                height: 210,
                color: Colors.teal[100],
              )
          ),
          _crearHeader(),
        ]
    );
  }
            
  Widget _crearHeader(){

    return Stack(
      children: [
        Positioned( top: 45, left: -19, child: _crearCirculo(50) ),
        Positioned( top: 25, right: 9, child: _crearCirculo(30) ),
        Positioned( top: -100, left: 119, child: _crearCirculo(150) ),

        Container(
          padding: EdgeInsetsDirectional.only(top: 45.0),
          child: Column(
            children: [
              Icon( Icons.pets, size: 60, color: Colors.blue[400],),
              SizedBox(width: double.infinity, height: 5,),
              Text('<Name App>', style: TextStyle(fontWeight: FontWeight.bold , fontSize: 26, color: Colors.blue[600] ),)

            ],
          ),
        )

      ],
    );
  }

  Widget _crearCirculo(double value){
  return Container(
      height: value,
      width: value,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.4),
      ),
    );
  }

  _register(BuildContext context, LoginBloc bloc) {                
    
    usuarioProvider.nuevoUsuario(bloc.email, bloc.password);
    
    //Navigator.pushReplacementNamed(context, 'home');


  }

          
}

class MyClipperStyleOne extends CustomClipper<Path> {
  
  bool reverse;

  MyClipperStyleOne({this.reverse = false});

  final int _coefficient = 4;
  double get _minStep => 1 / _coefficient;
  double get _preCenter => _minStep * (_coefficient / 2 - 1);
  double get _postCenter => _minStep * (_coefficient / 2 + 1);
  double get _preEnd => _minStep * (_coefficient - 2);

  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0.0, 0.0);
    if(!reverse) {
      path.lineTo(0.0, size.height - 30.0);
      path.lineTo(size.width * _preCenter, size.height - 20.0);
      path.cubicTo(size.width/2, size.height - 20.0, size.width/2, size.height - 40.0, size.width * _postCenter, size.height - 40.0);
      path.lineTo(size.width * _preEnd, size.height - 40.0);
      path.quadraticBezierTo(size.width, size.height - 40.0, size.width, size.height - 32.0);
      path.lineTo(size.width, 0.0);
      path.close();
    }else{
      path.lineTo(0.0, 20);
      path.lineTo(size.width * _preCenter, 20.0);
      path.cubicTo(size.width/2, 20.0, size.width/2, 40.0, size.width * _postCenter, 40.0);
      path.lineTo(size.width * _preEnd, 40.0);
      path.quadraticBezierTo(size.width, 40, size.width, 20.0);
      path.lineTo(size.width, 0.0);
      path.close();
    }

    return path;

  }
  
    @override
    bool shouldReclip(CustomClipper oldClipper) {    
      return true;
  }



}
