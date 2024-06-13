import 'package:flutter/material.dart';
import 'ApiService_Class.dart';
import 'Item_Models.dart';
import 'Photo _List_Screen.dart';

class AlbumListScreen extends StatefulWidget {
  final List<Photo> favorites;
  final Function(Photo) toggleFavorite;
  final bool Function(Photo) isFavorite;

  AlbumListScreen({
    required this.favorites,
    required this.toggleFavorite,
    required this.isFavorite,
  });

  @override
  _AlbumListScreenState createState() => _AlbumListScreenState();
}

class _AlbumListScreenState extends State<AlbumListScreen> {
  List<Album> _albums = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAlbums();
  }

  Future<void> _fetchAlbums() async {
    try {
      final albums = await ApiService().fetchAlbums();
      setState(() {
        _albums = albums;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Failed to fetch albums: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albums'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _albums.length,
        itemBuilder: (context, index) {
          final album = _albums[index];
          return ListTile(
            title: Text(album.title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PhotoListScreen(
                    albumId: album.id,
                    favorites: widget.favorites,
                    toggleFavorite: widget.toggleFavorite,
                    isFavorite: widget.isFavorite,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
