import 'package:dio/dio.dart';
import 'Item_Models.dart';


class ApiService {
  final Dio _dio = Dio();

  Future<List<Album>> fetchAlbums() async {
    try {
      final response = await _dio.get('https://jsonplaceholder.typicode.com/albums');
      final data = response.data as List;
      return data.map((json) => Album.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load albums');
    }
  }

  Future<List<Photo>> fetchPhotos(int albumId) async {
    try {
      final response = await _dio.get('https://jsonplaceholder.typicode.com/photos?albumId=$albumId');
      final data = response.data as List;
      return data.map((json) => Photo.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load photos');
    }
  }
}
