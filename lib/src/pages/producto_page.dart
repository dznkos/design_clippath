import 'package:flutter/material.dart';

import 'package:form_val/src/utils/utils.dart' as utils;

class ProductoPage extends StatelessWidget {
  
  final formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Producto'),
        actions: [
          IconButton(
            icon: Icon( Icons.photo_size_select_actual),  
            onPressed: (){}
          ),
          IconButton(
            icon: Icon( Icons.camera_alt),  
            onPressed: (){}
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _crearNombreProducto(),
                _crearPrecioProducto(),
                SizedBox(height: 10.0),
                _crearButtonProducto(),
            ],
          )
          ),
      ),
    ) 
    ,
  );
}
                                                
  Widget _crearNombreProducto() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto name',
      ),
      validator: (value){
        if ( value.length < 3){
          return 'Ingrese el nombre del producto';
        }else{
          return null;
        }
      },
    );
  }

  Widget _crearPrecioProducto() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Precio',
      ),
      validator: (value){
        if ( utils.isNumeric(value) ){
          return null;
        }else{
          return 'solo numeros';
        }
      },
    );
  }

  Widget _crearButtonProducto(){

    return RaisedButton.icon(
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      color: Colors.blue[300],
      textColor: Colors.white,
      onPressed: _submit
      ,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)        
      )
    );
  }

  void _submit(){
    if ( !formKey.currentState.validate() ) return;

    print('Login Correcto');
  }

}