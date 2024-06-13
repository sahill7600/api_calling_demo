import 'package:flutter/material.dart';
import 'Album_List_Screen.dart';
import 'Favorites_Screen.dart';
import 'Item_Models.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Photo> favorites = [];

  void toggleFavorite(Photo photo) {
    setState(() {
      if (favorites.contains(photo)) {
        favorites.remove(photo);
      } else {
        favorites.add(photo);
      }
    });
  }

  bool isFavorite(Photo photo) {
    return favorites.contains(photo);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AlbumListScreen(
        favorites: favorites,
        toggleFavorite: toggleFavorite,
        isFavorite: isFavorite,
      ),
      routes: {
        '/favorites': (context) => FavoritesScreen(
          favorites: favorites,
          toggleFavorite: toggleFavorite,
        ),
      },
    );
  }
}