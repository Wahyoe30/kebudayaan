// To parse this JSON data, do
//
//     final modelBerita = modelBeritaFromJson(jsonString);

import 'dart:convert';

ModelBerita modelBeritaFromJson(String str) => ModelBerita.fromJson(json.decode(str));

String modelBeritaToJson(ModelBerita data) => json.encode(data.toJson());

class ModelBerita {
  bool sukses;
  int status;
  String pesan;
  List<Datum> data;

  ModelBerita({
    required this.sukses,
    required this.status,
    required this.pesan,
    required this.data,
  });

  factory ModelBerita.fromJson(Map<String, dynamic> json) => ModelBerita(
    sukses: json["sukses"],
    status: json["status"],
    pesan: json["pesan"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "sukses": sukses,
    "status": status,
    "pesan": pesan,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String idBerita;
  String judulBerita;
  String deskripsi;
  String gambarBerita;

  Datum({
    required this.idBerita,
    required this.judulBerita,
    required this.deskripsi,
    required this.gambarBerita,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idBerita: json["id_berita"],
    judulBerita: json["judul_berita"],
    deskripsi: json["deskripsi"],
    gambarBerita: json["gambar_berita"],
  );

  Map<String, dynamic> toJson() => {
    "id_berita": idBerita,
    "judul_berita": judulBerita,
    "deskripsi": deskripsi,
    "gambar_berita": gambarBerita,
  };
}
