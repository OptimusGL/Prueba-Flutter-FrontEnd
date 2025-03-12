import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prueba_tecnica_flutter/src/models/response_api.dart';
import 'package:prueba_tecnica_flutter/src/models/user.dart';
import 'package:prueba_tecnica_flutter/src/providers/users_provider.dart';

class LoginController extends GetxController {

  User user = User.fromJson(GetStorage().read('user') ?? {});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  void goToRegisterPage() {
    Get.toNamed('/register');
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    print('Email ${email}');
    print('Password ${password}');

    if (isValidForm(email, password)) {

      ResponseApi responseApi = await usersProvider.login(email, password);

      print('Response Api: ${responseApi.toJson()}');
      /*print('Roles length: ${myUser.roles!.length}');*/
      
      if (responseApi.success == true) {
        GetStorage().write('user', responseApi.data); // Datos de usuario en sesión
        User myUser = User.fromJson(GetStorage().read('user') ?? {});

        print('Roles length: ${myUser.roles!.length}');

        if (myUser.roles!.length > 1) {
          goToRolesPage();
        }
        else { // Sólo un rol
          goToClientProductPage();
        }
      }
      else {
        Get.snackbar('Login fallido', responseApi.message ?? '');
      }
    }
  }

  void goToClientProductPage() {
    Get.offNamedUntil('/client/products/list', (route) => false);
  }

  void goToRolesPage() {
    Get.offNamedUntil('/roles', (route) => false);
  }

  bool isValidForm(String email, String password) {

    if (email.isEmpty) {
      Get.snackbar('Formulario no válido', 'Debes ingresar el email');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Formulario no válido', 'El email no es válido');
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar('Formulario no válido', 'Debes ingresar el password');
      return false;
    }

    return true;
  }
}