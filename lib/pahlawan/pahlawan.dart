import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:kebudayaan/apiUrl.dart';
import 'package:kebudayaan/model/modelPahlawan.dart';
import 'package:kebudayaan/pahlawan/addPahlawan.dart';
import 'package:kebudayaan/pahlawan/detailPahlawan.dart';

class PahlawanPage extends StatefulWidget {
  const PahlawanPage({Key? key}) : super(key: key);

  @override
  State<PahlawanPage> createState() => _PahlawanPageState();
}

class _PahlawanPageState extends State<PahlawanPage> {
  var logger = Logger();

  String? userName;
  TextEditingController searchController = TextEditingController();
  late List<Datum> pahlawanList = [];
  late List<Datum> filteredPahlawanList = [];

  @override
  void initState() {
    super.initState();
    getPahlawanList();
  }

  Future<void> getPahlawanList() async {
    try {
      http.Response res = await http
          .get(Uri.parse('${ApiUrl().baseUrl}read.php?data=pahlawan'));
      logger.d("data di dapat :: ${modelPahlawanFromJson(res.body).data}");
      setState(() {
        pahlawanList = modelPahlawanFromJson(res.body).data ?? [];
        filteredPahlawanList = pahlawanList;
      });
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  void filterPahlawanList(String query) {
    setState(() {
      filteredPahlawanList = pahlawanList
          .where((pahlawan) =>
          pahlawan.nama.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pahlawan Indonesia',
          style: TextStyle(
            fontFamily: 'Jost',
            fontSize: 21,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Color(0xFFF5F9FF),
      ),
      backgroundColor: Color(0xFFF5F9FF),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                controller: searchController,
                onChanged: filterPahlawanList,
                decoration: InputDecoration(
                  hintText: 'Cari pahlawan...',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      searchController.clear();
                      filterPahlawanList('');
                    },
                  )
                      : null,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredPahlawanList.length,
                itemBuilder: (context, index) {
                  Datum data = filteredPahlawanList[index];
                  return Padding(
                    padding: EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPahlawan(data),
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  '${ApiUrl().baseUrl}${data?.foto}',
                                  width: 150,
                                  height: 100,
                                  fit: BoxFit.cover, // Penyesuaian gambar agar tidak terlihat gepeng
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${data.nama}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                        height: 4),
                                    Text(
                                      "${data.deskripsi}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TambahDataPahlawan()),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.green[900],
      ),
    );
  }
}
