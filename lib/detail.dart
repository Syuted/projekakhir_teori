import 'package:flutter/material.dart';
import 'package:projekakhir_teori/favorite_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StationDetailPage extends StatefulWidget {
  final Map<String, dynamic> stationData;

  StationDetailPage({required this.stationData});

  @override
  State<StationDetailPage> createState() => _StationDetailPageState();
}

class _StationDetailPageState extends State<StationDetailPage> {
  late Box<FavoriteModel> favoritesBox;
  String textSnackBar = "";
  bool isAddFav = false;

  @override
  void initState() {
    super.initState();
    favoritesBox = Hive.box<FavoriteModel>('favoritesBox');
  }

  bool isFavorite(String code) {
    return favoritesBox.containsKey(code);
  }

  void toggleFavorite() {
    final String code = widget.stationData['code'];
    final String name = widget.stationData['name'];
    final String cityname = widget.stationData['cityname'];
    if (isFavorite(code)) {
      textSnackBar = "Berhasil Menghapus dari Stasiun Favorit";
      isAddFav = false;
      favoritesBox.delete(code);
    } else {
      textSnackBar = "Berhasil menambahkan ke Stasiun Favorit";
      isAddFav = true;
      favoritesBox.put(
        code,
        FavoriteModel(
          code: code,
          isFavorite: true,
          name: name,
          cityname: cityname,
        ),
      );
    }
    SnackBar snackBar = SnackBar(
      backgroundColor: (isAddFav) ? Colors.green : Colors.red,
      content: Text(textSnackBar),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text(
          'Detail Statiun',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        shape: const Border(
          bottom: BorderSide(),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nama Stasiun: ${widget.stationData['name']}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                'Kota Stasiun: ${widget.stationData['cityname']}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 12),
              Text(
                'Code Stasiun: ${widget.stationData['code']}',
                style: const TextStyle(fontSize: 20),
              ),
              const Divider(
                color: Colors.black,
              ),
              const SizedBox(height: 12),
              Text(
                'Deskripsi Stasiun:',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Ini adalah stasiun kereta api yang terletak di ${widget.stationData['cityname']}. Stasiun ini menyediakan layanan kereta api dengan kode ${widget.stationData['code']}.',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  toggleFavorite();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 2,
                  padding: const EdgeInsets.all(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Tambahkan Ke Favorit',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      isFavorite(widget.stationData['code'])
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color: isFavorite(widget.stationData['code'])
                          ? Colors.amber
                          : Colors.white,
                      size: 28,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(FavoriteModelAdapter());
  await Hive.openBox<FavoriteModel>('favoritesBox');

  runApp(MaterialApp(
    home: StationDetailPage(
      stationData: const {
        'name': 'Contoh Stasiun',
        'cityname': 'Contoh Kota',
        'code': '123',
        'isFavorite': true,
        // Tambahkan data stasiun lainnya sesuai kebutuhan
      },
    ),
  ));
}
