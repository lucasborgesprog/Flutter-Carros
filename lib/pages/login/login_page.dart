import 'dart:async';

import 'package:carros_custom/pages/api_response.dart';
import 'package:carros_custom/pages/carros/home_page.dart';
import 'package:carros_custom/pages/login/login_bloc.dart';
import 'package:carros_custom/pages/login/usuario.dart';
import 'package:carros_custom/utils/alert.dart';
import 'package:carros_custom/utils/nav.dart';
import 'package:carros_custom/widgets/app_button.dart';
import 'package:carros_custom/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _tLogin = TextEditingController(text: "admin");

  final _tSenha = TextEditingController(text: "123");

  final _formKey = GlobalKey<FormState>();

  final _focusSenha = FocusNode();

  final _bloc = LoginBloc();

  @override
  void initState() {
    super.initState();

    Future<Usuario> future = Usuario.get();
    future.then((Usuario user) {
      if (user != null) {
        setState(() {
          push(context, HomePage(), replace: true);
        });
      }
    });
  }

  // _loadUser() async {
  //   Usuario user = await Usuario.get();

  //   if (user != null) {
  //     setState(() {
  //       push(context, HomePage(), replace: true);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue[200],
                Colors.indigo[900],
              ],
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
              stops: [0.0, 1.0],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: FlutterLogo(
                  size: 250,
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    AppText(
                      "Login",
                      "Digite o Login",
                      controller: _tLogin,
                      validator: _validateLogin,
                      keyboardtype: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      nextFocus: _focusSenha,
                      icon: Icon(FontAwesomeIcons.user),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AppText(
                      "Senha",
                      "Digite a senha",
                      obscureText: true,
                      controller: _tSenha,
                      validator: _validateSenha,
                      keyboardtype: TextInputType.number,
                      focusNode: _focusSenha,
                      icon: Icon(FontAwesomeIcons.lock),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    StreamBuilder<bool>(
                        stream: _bloc.stream,
                        initialData: false,
                        builder: (context, snapshot) {
                          return AppButton(
                            "Login",
                            onPressed: _onClickButton,
                            showProgress: snapshot.data,
                          );
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onClickButton() async {
    if (!_formKey.currentState.validate()) {
      print("Existem campos incorretos");
      return;
    }

    String login = _tLogin.text;
    String senha = _tSenha.text;

    ApiResponse response = await _bloc.login(login, senha);

    if (response.ok) {
      //Usuario user = response.result;

      push(context, HomePage(), replace: true);
    } else {
      alert(context, "Login", response.msg);
    }
  }

  String _validateSenha(String value) {
    if (value.isEmpty) return "Digite a Senha";

    if (value.length < 3) return "A senha deve ter no mínimo 3 números";

    return null;
  }

  String _validateLogin(String value) {
    if (value.isEmpty) return "Digite o Login";

    return null;
  }

  @override
  void dispose() {
    super.dispose();

    _bloc.dispose();
  }
}
