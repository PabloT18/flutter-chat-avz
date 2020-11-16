import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/custum_btn.dart';
import 'package:chat_app/widgets/login_widget.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xffF2F2F2),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Logo(
                    title: "Register",
                  ),
                  _Form(),
                  Labes(
                    ruta: 'login',
                    label1: "Ya tienes cuenta?",
                    label2: "Logueate",
                  ),
                  Text(
                    "Terminos y condiciones de uso",
                    style: TextStyle(fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ),
          )),
    );
  }
}

class _Form extends StatefulWidget {
  _Form({Key key}) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final nameController = TextEditingController();
  final emalCtrl = TextEditingController();
  final pswCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.perm_identity,
            placeholder: "Nombre",
            // keyboardType: TextInputType.,
            textController: nameController,
          ),
          CustomInput(
            icon: Icons.map_outlined,
            placeholder: "Correo",
            keyboardType: TextInputType.emailAddress,
            textController: emalCtrl,
          ),
          CustomInput(
            icon: Icons.lock_open,
            placeholder: "Contrasena",
            textController: pswCtrl,
            isPSW: true,
          ),
          CustomButtom(
            label: "Ingrese",
            onPress: () {},
          ),
        ],
      ),
    );
  }
}
