// To parse this JSON data, do
//
//     final chatsResponse = chatsResponseFromJson(jsonString);

import 'dart:convert';

ChatsResponse chatsResponseFromJson(String str) =>
    ChatsResponse.fromJson(json.decode(str));

String chatsResponseToJson(ChatsResponse data) => json.encode(data.toJson());

class ChatsResponse {
  ChatsResponse({
    this.ok,
    this.mensajes,
  });

  bool ok;
  List<Mensaje> mensajes;

  factory ChatsResponse.fromJson(Map<String, dynamic> json) => ChatsResponse(
        ok: json["ok"],
        mensajes: List<Mensaje>.from(
            json["mensajes"].map((x) => Mensaje.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "mensajes": List<dynamic>.from(mensajes.map((x) => x.toJson())),
      };
}

class Mensaje {
  Mensaje({
    this.de,
    this.para,
    this.mensaje,
    this.createdAt,
    this.updatedAt,
  });

  String de;
  String para;
  String mensaje;
  DateTime createdAt;
  DateTime updatedAt;

  factory Mensaje.fromJson(Map<String, dynamic> json) => Mensaje(
        de: json["de"],
        para: json["para"],
        mensaje: json["mensaje"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "de": de,
        "para": para,
        "mensaje": mensaje,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
