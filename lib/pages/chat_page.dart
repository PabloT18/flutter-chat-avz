import 'dart:io';

import 'package:chat_app/models/chats-response.dart';
import 'package:chat_app/pages/chat_message.dart';
import 'package:chat_app/services/auth_servider.dart';
import 'package:chat_app/services/caht_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final textController = new TextEditingController();
  final _focusNode = new FocusNode();

  ChatService chatService;
  SocketService socketService;
  AuthService authService;

  bool writing = false;

  List<ChatMessage> _messages = [
    // ChatMessage(uid: '123', texto: "Holita"),
    // ChatMessage(uid: '123d', texto: "Holita"),
    // ChatMessage(uid: '123', texto: "Holi"),
    // ChatMessage(uid: 'd123', texto: "Holita"),
    // ChatMessage(uid: '123', texto: "Holita")
  ];

  @override
  void initState() {
    super.initState();
    this.chatService = Provider.of<ChatService>(context, listen: false);
    this.socketService = Provider.of<SocketService>(context, listen: false);
    this.authService = Provider.of<AuthService>(context, listen: false);

    this.socketService.socket.on("mensaje-personal", _esucharMensarje);

    _cartgarHistorial(this.chatService.usuarioPara.ui);
  }

  void _cartgarHistorial(String ui) async {
    List<Mensaje> chat = await this.chatService.getChats(ui);

    final history = chat.map(
      (mensaje) => new ChatMessage(
        texto: mensaje.mensaje,
        uid: mensaje.de,
        animationController: new AnimationController(
            vsync: this, duration: Duration(milliseconds: 0))
          ..forward(),
      ),
    );

    setState(() {
      _messages.insertAll(0, history);
    });
  }

  void _esucharMensarje(dynamic payload) {
    ChatMessage message = new ChatMessage(
        texto: payload['mensaje'],
        uid: payload['de'],
        animationController: new AnimationController(
            vsync: this, duration: Duration(microseconds: 300)));

    setState(() {
      _messages.insert(0, message);
    });

    message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    // final chatService = Provider.of<ChatService>(context);
    final usuarioPara = chatService.usuarioPara;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                child: Text(
                  usuarioPara.nombre.substring(0, 2),
                  style: TextStyle(fontSize: 12),
                ),
                backgroundColor: Colors.blue[100],
                maxRadius: 14,
              ),
              SizedBox(height: 3),
              Text(
                usuarioPara.nombre,
                style: TextStyle(color: Colors.black87, fontSize: 12),
              )
            ],
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: _messages.length,
                  itemBuilder: (_, i) => _messages[i],
                  reverse: true,
                ),
              ),
              Divider(height: 1),
              _inPutChat(),
            ],
          ),
        ));
  }

  Widget _inPutChat() {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: textController,
              onSubmitted: _handleSubmit,
              onChanged: (String texto) {
                setState(() {
                  if (texto.trim().length > 0) {
                    writing = true;
                  } else {
                    writing = false;
                  }
                });
              },
              decoration: InputDecoration.collapsed(
                hintText: 'Enviar mensaje',
              ),
              focusNode: _focusNode,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: Platform.isIOS
                ? CupertinoButton(child: Text("Enviar"), onPressed: () {})
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconTheme(
                      data: IconThemeData(color: Colors.blue[400]),
                      child: IconButton(
                        // highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        icon: Icon(Icons.send),
                        onPressed: writing
                            ? () => _handleSubmit(textController.text.trim())
                            : null,
                      ),
                    ),
                  ),
          )
        ],
      ),
    ));
  }

  _handleSubmit(String text) {
    if (text.length == 0) {
      return;
    }
    // print(text);

    final newMessage = new ChatMessage(
      uid: authService.usuario.ui,
      texto: text,
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 400)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      writing = false;
      _focusNode.requestFocus();
      textController.clear();
    });

    socketService.emit('mensaje-personal', {
      'de': this.authService.usuario.ui,
      'para': this.chatService.usuarioPara.ui,
      'mensaje': text,
    });
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }

    this.socketService.socket.off('mensaje-personal');
    super.dispose();
  }
}
