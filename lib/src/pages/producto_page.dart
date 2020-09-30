import 'package:flutter/material.dart';
import 'package:form_val/src/models/producto_model.dart';
import 'package:form_val/src/providers/productos_provider.dart';

import 'package:form_val/src/utils/utils.dart' as utils;

class ProductoPage extends StatefulWidget {
  
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final productoProvider = new ProductoProvider();

  ProductoModel producto = new ProductoModel();
  bool _guardando = false;

  @override
  Widget build(BuildContext context) {

    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;

    if ( prodData != null ){
      producto = prodData;
    }

    return Scaffold(
      key: scaffoldKey,
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
                _crearDisponible(),
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
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto name',
      ),
      onSaved: (value)=> producto.titulo = value,
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
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Precio',
      ),
      onSaved: (value)=> producto.valor = double.parse(value),
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
      onPressed: ( _guardando ) ? null : _submit,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)        
      )
    );
  }

  Widget _crearDisponible(){
    return SwitchListTile(
      value: producto.disponible, 
      title: Text('Disponible'),
      activeColor: Colors.green,
      onChanged: (value){
        setState(() {
          producto.disponible = value;
        });
      }
      );      

  }

  void _submit(){

    if ( !formKey.currentState.validate() ) return;

    formKey.currentState.save();
        
    setState(() {
      _guardando = true;
    });

    if ( producto.id == null ){
      productoProvider.crearProducto(producto);
    }else{
      productoProvider.actualizarProducto(producto);
    }

    setState(() {
      _guardando = false;
    });
    mostrarSnackBar('Registro guardado');

    Navigator.pop(context);

  }

  void mostrarSnackBar(String mensaje){

    final snackbar = SnackBar(
      content: Text( mensaje ),
      duration: Duration( milliseconds: 1500 ),
      );
      scaffoldKey.currentState.showSnackBar(snackbar);
  }
 
}