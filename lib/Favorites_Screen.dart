import 'package:flutter/material.dart';
import 'Item_Models.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Photo> favorites;
  final Function(Photo) toggleFavorite;

  FavoritesScreen({required this.favorites, required this.toggleFavorite});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: widget.favorites.isEmpty
          ? Center(child: Text('No favorites yet'))
          : ListView.builder(
        itemCount: widget.favorites.length,
        itemBuilder: (context, index) {
          final photo = widget.favorites[index];
          return ListTile(
            leading: Image.network(photo.thumbnailUrl, width: 50, height: 50, fit: BoxFit.cover),
            title: Text(photo.title),
            trailing: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                setState(() {
                  widget.toggleFavorite(photo);
                });
              },
            ),
          );
        },
      ),
    );
  }
}
