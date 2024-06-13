import 'package:flutter/material.dart';
import 'ApiService_Class.dart';
import 'Favorites_Screen.dart';
import 'Item_Models.dart';


class PhotoListScreen extends StatefulWidget {
  final int albumId;
  final List<Photo> favorites;
  final Function(Photo) toggleFavorite;
  final bool Function(Photo) isFavorite;

  PhotoListScreen({
    required this.albumId,
    required this.favorites,
    required this.toggleFavorite,
    required this.isFavorite,
  });

  @override
  _PhotoListScreenState createState() => _PhotoListScreenState();
}

class _PhotoListScreenState extends State<PhotoListScreen> {
  List<Photo> _photos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPhotos();
  }

  Future<void> _fetchPhotos() async {
    try {
      final photos = await ApiService().fetchPhotos(widget.albumId);
      setState(() {
        _photos = photos;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Failed to fetch photos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photos'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(
                    favorites: widget.favorites,
                    toggleFavorite: widget.toggleFavorite,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _photos.length,
        itemBuilder: (context, index) {
          final photo = _photos[index];
          final isFavorite = widget.isFavorite(photo);
          return ListTile(
            leading: Image.network(photo.thumbnailUrl, width: 50, height: 50, fit: BoxFit.cover),
            title: Text(photo.title),
            trailing: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
              ),
              onPressed: () {
                widget.toggleFavorite(photo);
                setState(() {});
              },
            ),
          );
        },
      ),
    );
  }
}
