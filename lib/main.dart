import 'package:chat_app/services/caht_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/services/auth_servider.dart';
import 'package:chat_app/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => AuthService(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => SocketService(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => ChatService(),
        )
      ],
      child: MaterialApp(
        title: 'Material App',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}
