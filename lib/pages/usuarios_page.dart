import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/services/auth_servider.dart';
import 'package:chat_app/services/caht_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/services/usuartios_servide.dart';
import 'package:provider/provider.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:flutter/material.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final usuariosService = new UsuariosService();

  List<Usuario> usuarios = [];

  // final usuarios = [
  //   Usuario(uid: '1', nombre: 'Maria', email: "test@tes.com", online: true),
  //   Usuario(uid: '2', nombre: 'Maria2', email: "test2@tes.com", online: true),
  //   Usuario(uid: '3', nombre: 'Pablo', email: "test3@tes.com", online: false),
  // ];

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    this._cargarUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<AuthService>(context).usuario;
    final sockectService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          usuario.nombre,
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          color: Colors.black87,
          onPressed: () {
            //TODO Desconectarnos del socket server
            sockectService.disconnect();

            AuthService.delToken();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: (sockectService.serverStatus == ServerStatus.Online)
                ? Icon(
                    Icons.check_circle,
                    color: Colors.blue[400],
                  )
                : Icon(
                    Icons.offline_bolt,
                    color: Colors.red[400],
                  ),
          ),
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUser,
        header: WaterDropHeader(
            complete: Icon(
              Icons.check,
              color: Colors.blue[400],
            ),
            waterDropColor: Colors.blue[400]),
        child: usersListView(),
      ),
    );
  }

  ListView usersListView() {
    return ListView.separated(
        itemBuilder: (_, i) => _userListTile(usuarios[i]),
        separatorBuilder: (_, i) => Divider(),
        itemCount: usuarios.length);
  }

  ListTile _userListTile(Usuario user) {
    return ListTile(
      title: Text(user.nombre),
      subtitle: Text(user.email),
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Text(user.nombre.substring(0, 2)),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: user.online ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.usuarioPara = user;
        Navigator.pushNamed(context, 'chat');
      },
    );
  }

  _cargarUser() async {
    print("Cargando");
    this.usuarios = await usuariosService.getUsuarios();

    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    setState(() {});
    _refreshController.refreshCompleted();
  }
}
