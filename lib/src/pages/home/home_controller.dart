import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prueba_tecnica_flutter/src/models/user.dart';

class HomeController extends GetxController {

  User user = User.fromJson(GetStorage().read('user') ?? {});

  HomeController() {
    print('USUARIO DE SESIÓN: ${user.toJson()}');
  }

  void signOut() {
    GetStorage().remove('user');

    Get.offNamedUntil('/', (route) => false); // Elimina el historial de pantallas
  }

}