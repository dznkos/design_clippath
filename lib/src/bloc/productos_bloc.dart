
import 'dart:io';

import 'package:form_val/src/models/producto_model.dart';
import 'package:form_val/src/providers/productos_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/subjects.dart';

class ProductosBloc{

  // podria ser StreamController pero para usar rxdart debe ser BehaviorSubject
  final _productosController = new BehaviorSubject<List<ProductoModel>>();
  final _cargandoController = new BehaviorSubject<bool>();


  final _productoProvider = new ProductoProvider();

  Stream<List<ProductoModel>> get productosStream => _productosController.stream;
  Stream<bool> get cargando => _cargandoController.stream;


  void cargarProductos() async{

    final productos = await _productoProvider.cargarProductos();
    _productosController.sink.add(productos);

  }

  void agregarProducto(ProductoModel producto) async {

    _cargandoController.sink.add(true);
    await _productoProvider.crearProducto(producto);
    _cargandoController.sink.add(false);

  }

  Future<String> subirFoto(PickedFile foto) async{

    _cargandoController.sink.add(true);
    final fotoUrl = await _productoProvider.subirImagen(foto);
    _cargandoController.sink.add(false);
  
    return fotoUrl;
  }

  void editarProducto(ProductoModel producto) async {

    _cargandoController.sink.add(true);
    await _productoProvider.actualizarProducto(producto);
    _cargandoController.sink.add(false);

  }

  void borrarProducto(String id) async {

    await _productoProvider.borrarProducto(id);    
  }


  dispose(){
    _productosController?.close();
    _cargandoController?.close();
  }


}