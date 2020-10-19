
import 'dart:convert';
import 'package:form_val/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:form_val/src/models/producto_model.dart';
import 'package:image_picker/image_picker.dart';

import 'package:mime_type/mime_type.dart';

class ProductoProvider{


  final String _url = 'https://flutter-sun.firebaseio.com';

  final _prefs = new PreferenciasUsuario();

  Future<bool> crearProducto(ProductoModel producto) async{

    final url = '$_url/productos.json?auth=${ _prefs.token }';
    
    final resp = await http.post(url, body: productoModelToJson(producto));

    final decodeData = json.decode(resp.body);

    //print('Error ' + decodeData );
    return true;
  }

  Future<List<ProductoModel>> cargarProductos() async{

    final url = '$_url/productos.json?auth=${ _prefs.token }';
    
    final resp = await http.get(url);

    final Map<String,dynamic> decodeData = json.decode(resp.body);

    final List<ProductoModel> productos = new List();

    if ( decodeData == null ) return [];

    if ( decodeData['error'] != null ) return [];
    
    decodeData.forEach((id, pro) {
      
      final prod = ProductoModel.fromJson(pro);
      prod.id = id;

      productos.add(prod);
    
    });

    print( productos );

    return productos;
  }

  Future<int> borrarProducto(String id) async{

    final url = '$_url/productos/$id.json?auth=${ _prefs.token }';
    final resp = await http.delete(url);

    print( resp.body );

    return 1;
  }

  Future<bool> actualizarProducto(ProductoModel producto) async{

    final url = '$_url/productos/${producto.id}.json?auth=${ _prefs.token }';

    final resp = await http.put(url, body: productoModelToJson(producto));

    final Map<String,dynamic> decodeData = json.decode(resp.body);

    print(decodeData);

    return true;
  }

  Future<String> subirImagen (PickedFile imagen) async{

  final url = Uri.parse('https://api.cloudinary.com/v1_1/dynhppkuw/image/upload?upload_preset=k562cx25');
  final mimeType = mime(imagen.path).split('/'); // image/jpeg

  final imageUploadRequest = http.MultipartRequest(
    'POST',
    url
  );

  final file = await http.MultipartFile.fromPath(
    'file', 
    imagen.path,
    contentType: MediaType( mimeType[0], mimeType[1]),
    ); 

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if ( resp.statusCode != 200 && resp.statusCode != 201 ){

      print('Algo salio mal');
      print( resp.body );
      return null;
    }

    final respData = json.decode(resp.body);
    print( respData );

    return respData['secure_url'];

  }

}