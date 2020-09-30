

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:form_val/src/models/producto_model.dart';

class ProductoProvider{


  final String _url = 'https://flutter-sun.firebaseio.com';


  Future<bool> crearProducto(ProductoModel producto) async{

    final url = '$_url/productos.json';
    
    final resp = await http.post(url, body: productoModelToJson(producto));

    final decodeData = json.decode(resp.body);

    //print('Error ' + decodeData );
    return true;
  }

  Future<List<ProductoModel>> cargarProductos() async{

    final url = '$_url/productos.json';
    
    final resp = await http.get(url);

    final Map<String,dynamic> decodeData = json.decode(resp.body);

    final List<ProductoModel> productos = new List();

    if ( decodeData == null ) return [];
    
    decodeData.forEach((id, pro) {
      
      final prod = ProductoModel.fromJson(pro);
      prod.id = id;

      productos.add(prod);
    
    });

    print( productos );

    return productos;
  }

  Future<int> borrarProducto(String id) async{

    final url = '$_url/productos/$id.json';
    final resp = await http.delete(url);

    print( resp.body );

    return 1;
  }

  Future<bool> actualizarProducto(ProductoModel producto) async{

    final url = '$_url/productos/${producto.id}.json';

    final resp = await http.put(url, body: productoModelToJson(producto));

    final Map<String,dynamic> decodeData = json.decode(resp.body);

    print(decodeData);

    return true;
  }

}