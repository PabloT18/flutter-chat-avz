import 'package:chat_app/global/enviroment.dart';
import 'package:chat_app/models/chats-response.dart';
import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/services/auth_servider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier {
  Usuario usuarioPara;

  Future<List<Mensaje>> getChats(String usuarioID) async {
    final resp = await http.get('${Enviroments.apiURL}/mensajes/$usuarioID',
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken()
        });

    final chatsResponse = chatsResponseFromJson(resp.body);

    return chatsResponse.mensajes;
  }
}
