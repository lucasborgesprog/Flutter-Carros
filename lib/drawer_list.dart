import 'package:carros_custom/pages/login/login_page.dart';
import 'package:carros_custom/pages/login/usuario.dart';
import 'package:carros_custom/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Future<Usuario> future = Usuario.get();

    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder(
              future: future,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                Usuario user = snapshot.data;
                print("Userr >> $user");
                return user != null ? _header(user) : Container();
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.star),
              title: Text("Favoritos"),
              subtitle: Text("mais informações..."),
              trailing: Icon(FontAwesomeIcons.arrowRight),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.question),
              title: Text("Ajuda"),
              subtitle: Text("mais informações..."),
              trailing: Icon(FontAwesomeIcons.arrowRight),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.signOutAlt),
              title: Text("Logout"),
              trailing: Icon(FontAwesomeIcons.arrowRight),
              onTap: () => _onClickLogout(context),
            ),
          ],
        ),
      ),
    );
  }

  _header(Usuario user) {
    return UserAccountsDrawerHeader(
      accountEmail: Text(user.email),
      accountName: Text(user.nome),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(user.urlFoto),
      ),
    );
  }

  _onClickLogout(BuildContext context) {
    Usuario.clear();
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }
}
