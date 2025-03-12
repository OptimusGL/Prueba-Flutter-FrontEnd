import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_tecnica_flutter/src/pages/login/login_controller.dart';

class LoginPage extends StatelessWidget {

  LoginController con = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 50,
        child: _textDontHaveAccount(),
      ),
      body: Stack( // Posicionar elementos uno encima del otro
        children: [
          _backgroundCover(context),
          _boxForm(context),
          Column( // Posicionar elementos uno debajo del otro (vertical)
            children: [
              _imageCover(),
              _textAppName()
            ],
          ),
        ],
      ),
    );
  }

  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery
          .of(context)
          .size
          .height * 0.4,
      color: Colors.amber,
    );
  }

  Widget _textAppName() {
    return Text(
      'DELIVERY MySQL',
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black
      ),
    );
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.45,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.35, left: 50, right: 50),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black54,
            blurRadius: 15,
            offset: Offset(0, 0.75)
          )
        ]
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textYourInfo(),
            _textFieldEmail(),
            _textFieldPassword(),
            _buttonLogin()
          ],
        ),
      ),
    );
  }

  Widget _textFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: TextField(
        controller: con.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'Correo Electrónico',
            prefixIcon: Icon(Icons.email)
        ),
      ),
    );
  }

  Widget _textFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: TextField(
        controller: con.passwordController,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Contraseña',
            prefixIcon: Icon(Icons.lock)
        ),
      ),
    );
  }

  Widget _buttonLogin() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: ElevatedButton(
          onPressed: () => con.login(),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15),
            backgroundColor: Colors.amber,
            overlayColor: Colors.red
          ),
          child: Text(
            'LOGIN',
            style: TextStyle(
                color: Colors.black
            ),
          )
      ),
    );
  }

  Widget _textYourInfo() {
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 45),
      child: Text(
          'INGRESA ESTA INFORMACIÓN',
        style: TextStyle(
          color: Colors.black
        ),
      ),
    );
  }

  Widget _textDontHaveAccount() {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Row( // Ubicar elementos uno al lado del otro (horizontal)
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '¿No tienes cuenta?',
            style: TextStyle(
                color: Colors.black,
                fontSize: 17
            ),
          ),
          SizedBox(width: 7),
          GestureDetector(
            onTap: () => con.goToRegisterPage(),
            child: Text(
              '¡Regístrate aquí!',
              style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: 17
              ),
            ),
          )
        ],
      ),
    );
  }

  // Privado
  Widget _imageCover() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 50, bottom: 15),
        alignment: Alignment.center,
        child: Image.asset(
          'assets/img/delivery.png',
          width: 200,
          height: 157,
        ),
      ),
    );
  }
}
