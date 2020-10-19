import 'package:flutter/material.dart';
import 'package:form_val/src/bloc/provider.dart';

import 'package:form_val/src/models/producto_model.dart';

import 'package:form_val/src/providers/productos_provider.dart';

class HomePage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {

    final productosBloc = Provider.productosBloc(context);
    productosBloc.cargarProductos();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: _cargarProductos(productosBloc),
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
      
  Widget _cargarProductos(ProductosBloc productosBloc) {

        return StreamBuilder(
          stream: productosBloc.productosStream,
          builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot){

            if ( snapshot.hasData ) {  
              final productos = snapshot.data;
              
              return ListView.builder(
                itemCount: productos.length,
                itemBuilder: (context, i) => _crearItem(context,productosBloc,productos[i]),
              );
            
            }else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }        
        );        
  }

  Widget _crearItem(BuildContext context, ProductosBloc productosBloc, ProductoModel producto){

        return Dismissible(
          key: UniqueKey(),
          background: Container(
            color: Colors.red,
          ),
            onDismissed: (direccion )=> productosBloc.borrarProducto(producto.id),
            child: Card(
              child: Column(
                children: [
                  ( producto.fotoUrl == null )
                    ? Image(image: AssetImage('assets/no-image.png'))
                    : FadeInImage(
                      placeholder: AssetImage('assets/jar-loading.gif'), 
                      image: NetworkImage( producto.fotoUrl),
                      height: 300.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    ListTile(
                      title: Text(' ${producto.titulo} - ${producto.valor}'),
                      subtitle: Text(' ${producto.id} '),
                      onTap: () => Navigator.pushNamed(context, 'producto', arguments: producto),
                    ),
                ],
              ),
            )
        );
      }
}

