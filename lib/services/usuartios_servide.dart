import 'package:chat_app/global/enviroment.dart';
import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/models/usuarios_response.dart';
import 'package:chat_app/services/auth_servider.dart';
import 'package:http/http.dart' as http;

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final resp = await http.get('${Enviroments.apiURL}/usuarios', headers: {
        'Content_Type': 'application/json',
        'x-token': await AuthService.getToken()
      });

      final usuariosResponse = usuariosResponseFromJson(resp.body);
      print(usuariosResponse);

      return usuariosResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}
