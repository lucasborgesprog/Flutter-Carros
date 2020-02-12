import 'package:carros_custom/pages/carros/home_page.dart';
import 'package:carros_custom/pages/login/login_page.dart';
import 'package:carros_custom/pages/login/usuario.dart';
import 'package:carros_custom/utils/nav.dart';
import 'package:carros_custom/utils/sql/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // Inicializar o banco de dados
    Future futureA = DatabaseHelper.getInstance().db;

    Future futureB = Future.delayed(Duration(seconds: 3));

    // Usuario
    Future<Usuario> futureC = Usuario.get();

    Future.wait([futureA, futureB, futureC]).then((List values) {
      Usuario user = values[2];
      print(user);

      if (user != null) {
        push(context, HomePage(), replace: true);
      } else {
        push(context, LoginPage(), replace: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: FlareActor(
        "assets/splash-github.flr",
        alignment: Alignment.center,
        fit: BoxFit.contain,
        animation: "git",
      ),
    );
  }
}
