

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:form_val/src/models/producto_model.dart';

class ProductoProvider{


  final String _url = 'https://flutter-sun.firebaseio.com';


  Future<bool> crearProducto(ProductoModel producto) async{

    final url = '$_url/productos.json';
    
    final resp = await http.post(url, body: productoModelToJson(producto));

    final decodeData = json.decode(resp.body);

    return true;
  }



}