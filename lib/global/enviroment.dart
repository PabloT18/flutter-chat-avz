import 'dart:io';

class Enviroments {
  static String apiURL = Platform.isAndroid
      ? 'http://192.168.100.15:3000/api'
      : "http://localhots:3000/api";

  static String socketURL =
      Platform.isAndroid ? 'http://10.0.2.2:3000' : "http://localhots:3000";
}
