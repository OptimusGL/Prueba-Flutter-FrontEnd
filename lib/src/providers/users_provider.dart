import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:get/get.dart';
import 'package:prueba_tecnica_flutter/src/environment/environment.dart';
import 'package:prueba_tecnica_flutter/src/models/response_api.dart';
import 'package:prueba_tecnica_flutter/src/models/user.dart';
import 'package:http/http.dart' as http;

class UsersProvider extends GetConnect {

  String url = '${Environment.API_URL}api/users';
  /*String url = Environment.API_URL + 'api/users';*/

  Future<Response> create(User user) async {
    Response response = await post(
      '$url/create',
        user.toJson(),
        headers: {
          'Content-Type': 'application/json'
        }
    ); // Esperar hasta que el servidor retorne la respuesta

    return response;
  }

  /*Future<void> createUserWithImage() async {
    final url = Uri.parse('http://192.168.1.69:3007/api/users/createWithImage');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'id': '',
          'email': 'jc.cuellar.ruz@gmail.com',
          'name': 'Juan Carlos',
          'lastname': 'Cuéllar',
          'phone': '5635555255',
          'image': 'https://firebasestorage.googleapis.com/v0/b/flutter-test-4d743.firebasestorage.app/o/Paye2.jpg?alt=media&token=21bdcbb4-5cf8-4aa1-a0bd-8c12dda45c32',
          'password': 'pass12345',
        }),
      );

      if (response.statusCode == 200) {
        print('Usuario creado exitosamente');
      } else {
        print('Error al crear el usuario: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }*/

  Future<Stream> createWithImage(User user, File image) async {
    Uri uri = Uri.http(Environment.API_URL_OLD, '/api/users/createWithImage');
    /*Uri uri = Uri.parse('http://192.168.1.69:3007/api/users/createWithImage');*/

    final request = http.MultipartRequest('POST', uri);
    request.files.add(http.MultipartFile(
      'image',
      http.ByteStream(image.openRead().cast()),
      await image.length(),
      filename: basename(image.path)
    ));
    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  /*
  * GET X
   */
  Future<ResponseApi> createUserWithImageGetX(User user, File image) async {
    FormData form = FormData({
      'image': MultipartFile(image, filename: basename(image.path)),
      'user': json.encode(user)
    });
    Response response = await post('$url/createWithImage', form);

    if (response.body == null) {
      Get.snackbar('Error en la petición', 'No se pudo crear el usuario');
      return ResponseApi(success: true, message: '');
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

  Future<ResponseApi> login(String email, String password) async {
    Response response = await post(
      '$url/login', {
        'email': email,
        'password': password
      },
      headers: {
        'Content-Type': 'application/json'
      }
    ); // Esperar hasta que el servidor retorne la respuesta

    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo ejecutar la petición');
      return ResponseApi(success: true, message: '');
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }
} 