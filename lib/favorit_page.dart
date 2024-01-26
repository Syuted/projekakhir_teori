import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:projekakhir_teori/detail.dart';
import 'package:projekakhir_teori/favorite_model.dart';
import 'favorite_model.dart';

class FavoriteStation extends StatefulWidget {
  final List<dynamic> stationsFav;

  FavoriteStation({super.key, required this.stationsFav});

  @override
  State<FavoriteStation> createState() => _FavoriteStationState();
}

class _FavoriteStationState extends State<FavoriteStation> {
  late Box<FavoriteModel> favoritesBox;
  late FavoriteModel? favorite;

  late Map<String, dynamic> stationData;

  @override
  void initState() {
    final String code = widget.stationsFav[0]['code'];
    favoritesBox = Hive.box('favoritesBox');
    favorite = favoritesBox.get(code);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text(
          'Station Favorit',
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
      body: favoritesBox.isEmpty
          ? const Center(
        child: Text(
          "Anda belum memiliki Station Favorite",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(18),
        child: ListView.builder(
          itemCount: favoritesBox.length,
          itemBuilder: (BuildContext context, int index) {
            var fav = favoritesBox.getAt(index);
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 5,
              ),
              child: Card(
                color: Colors.grey.shade200,
                child: ListTile(
                  title: Text(
                    fav!.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(fav.cityname),
                  trailing: Text(fav.code),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StationDetailPage(
                          stationData: {
                            'name': fav.name,
                            'cityname': fav.cityname,
                            'code': fav.code,
                          },
                        ),
                      ),
                    ).then((value) => setState(() {}));
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
