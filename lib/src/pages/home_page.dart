import 'package:flutter/material.dart';

import 'package:form_val/src/bloc/provider_bloc.dart';
import 'package:form_val/src/models/producto_model.dart';

import 'package:form_val/src/providers/productos_provider.dart';

class HomePage extends StatelessWidget {
  
  final productoProvider = new ProductoProvider();

  @override
  Widget build(BuildContext context) {

    final login = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: _cargarProductos(),
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
      
      Widget _cargarProductos() {

        return FutureBuilder(
          future: productoProvider.cargarProductos(),
          builder: (context, AsyncSnapshot<List<ProductoModel>> snapshot) {
            
            if ( snapshot.hasData ) {  

              final productos = snapshot.data;
              
              return ListView.builder(
                itemCount: productos.length,
                itemBuilder: (context, i) => _crearItem(context,productos[i]),
              );
            
            }else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

          },          
        );
      }

      Widget _crearItem(BuildContext context, ProductoModel producto){

        return Dismissible(
          key: UniqueKey(),
          background: Container(
            color: Colors.red,
          ),
            onDismissed: (direccion ){
              productoProvider.borrarProducto( producto.id);
            },
            child: ListTile(
            title: Text(' ${producto.titulo} - ${producto.valor}'),
            subtitle: Text(' ${producto.id} '),
            onTap: () => Navigator.pushNamed(context, 'producto', arguments: producto),
          ),
        );
      }
}