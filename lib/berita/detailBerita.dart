import 'package:flutter/material.dart';
import 'package:kebudayaan/apiUrl.dart';
import 'package:kebudayaan/model/modelBerita.dart';

class PageDetailBerita extends StatelessWidget {
  final Datum? data;

  const PageDetailBerita(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          data!.judulBerita,
          style: TextStyle(
            color: Colors.white, // Warna putih
          ),
        ),
        backgroundColor: Colors.green[900],
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                '${ApiUrl().baseUrl}${data?.gambarBerita}',
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListTile(
            title: Text(
              data?.judulBerita ?? "",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              data?.deskripsi ?? "",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
