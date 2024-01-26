import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:projekakhir_teori/favorite_model.dart';
import 'package:projekakhir_teori/detail.dart';
import 'detail.dart';
import 'favorit_page.dart';
import 'favorite_model.dart';

class StationList extends StatefulWidget {
  const StationList({Key? key}) : super(key: key);

  @override
  State<StationList> createState() => StationPageState();
}

class StationPageState extends State<StationList> {
  late Box<FavoriteModel> favoritesBox;

  List<dynamic> allStations = [];

  @override
  void initState() {
    favoritesBox = Hive.box('favoritesBox');
    fetchStations().then((stations) {
      setState(() {
        allStations = stations;
      });
    });
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
          'Station',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        shape: const Border(
          bottom: BorderSide(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: StationSearch(allStations),
                ).then((value) => setState(() {}));
              },
              icon: const Icon(
                Icons.search_rounded,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FavoriteStation(stationsFav: allStations),
                    ),
                  ).then((value) => setState(() {}));
                },
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Colors.grey.shade400,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Daftar',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white),
                        ),
                        const Text(
                          'Stasiun Favorit',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white),
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Stasion Favorite:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.white),
                            ),
                            Text(
                              '${favoritesBox.length}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 12, bottom: 8),
                child: Text(
                  'List Stasiun',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
              ),
              allStations.isEmpty
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: allStations.length,
                itemBuilder: (BuildContext context, int index) {
                  var station = allStations[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      // color: Colors.yellowAccent,
                      child: ListTile(
                        title: Text(
                          station['name'] ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(station['cityname'] ?? ''),
                        trailing: Text(station['code'] ?? ''),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  StationDetailPage(
                                    stationData: station,
                                  ),
                            ),
                          ).then((value) => setState(() {}));
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<dynamic>> fetchStations() async {
    final response =
    await http.get(Uri.parse('https://booking.kai.id/api/stations2'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load stations');
    }
  }
}

class StationSearch extends SearchDelegate<String> {
  final List<dynamic> stations;

  StationSearch(this.stations);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implementasi pencarian hasil
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<dynamic> suggestionList = query.isEmpty
        ? []
        : stations
        .where((station) => station['name']
        .toString()
        .toLowerCase()
        .contains(query.toLowerCase()))
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (BuildContext context, int index) {
          var suggestion = suggestionList[index];
          return Column(
            children: [
              ListTile(
                title: Text(suggestion['name'] ?? ''),
                subtitle: Text(suggestion['cityname'] ?? ''),
                trailing: Text(suggestion['code'] ?? ''),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          StationDetailPage(stationData: suggestion),
                    ),
                  );
                },
              ),
              const Divider(
                color: Colors.black,
              ),
            ],
          );
        },
      ),
    );
  }
}
