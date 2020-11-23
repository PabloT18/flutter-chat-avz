import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/usuarios_page.dart';
import 'package:chat_app/services/auth_servider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Text('Cargando...'),
          );
        },
        // child:
      ),
    );
  }

  Future checLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final autenticado = await authService.isLoggedIn();

    if (autenticado) {
      //TODO : Conectado a l socekr server
      // Navigator.pushReplacementNamed(context, 'usuarios');

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (
              _,
              __,
              ___,
            ) =>
                UsuariosPage(),
            transitionDuration: Duration(seconds: 3)),
      );
    } else {
      // Navigator.pushReplacementNamed(context, 'login');
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (
              _,
              __,
              ___,
            ) =>
                LoginPage(),
            transitionDuration: Duration(seconds: 3)),
      );
    }
  }
}
