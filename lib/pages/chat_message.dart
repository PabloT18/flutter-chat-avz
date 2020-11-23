import 'package:chat_app/services/auth_servider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {
  final String texto;
  final String uid;

  final AnimationController animationController;

  const ChatMessage({
    Key key,
    @required this.texto,
    @required this.uid,
    @required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      child: FadeTransition(
        opacity: animationController,
        child: Container(
          child: this.uid == authService.usuario.ui ? _myMessage() : _message(),
        ),
      ),
    );
  }

  Widget _myMessage() {
    return Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.only(bottom: 5, left: 60, right: 8),
          child: Text(
            this.texto,
            style: TextStyle(color: Colors.white),
          ),
          decoration: BoxDecoration(
              color: Color(0xff4D9EF6),
              borderRadius: BorderRadius.circular(20)),
        ));
  }

  Widget _message() {
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.only(bottom: 5, left: 8, right: 60),
          child: Text(
            this.texto,
            style: TextStyle(color: Colors.black87),
          ),
          decoration: BoxDecoration(
              color: Color(0xffE4E5E8),
              borderRadius: BorderRadius.circular(20)),
        ));
  }
}
