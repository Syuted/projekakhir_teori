import 'package:flutter/material.dart';
import 'login.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projekakhir_teori/favorite_model.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<FavoriteModel>(FavoriteModelAdapter());
  await Hive.openBox<FavoriteModel>('favoritesBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PROJEK AKHIR',
      theme: ThemeData(
        primaryColor: Colors.black, // Set primary color to black
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}
