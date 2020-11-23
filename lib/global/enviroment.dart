import 'dart:io';

class Enviroments {
  static String apiURL = Platform.isAndroid
      ? 'http://192.168.100.15:3000/api'
      : "http://localhots:3000/api";

  static String SOCKETURL = Platform.isAndroid
      ? 'http://192.168.100.15:3000'
      : "http://localhots:3000";
}
