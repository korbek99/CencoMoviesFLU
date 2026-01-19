import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class MovieService {
  static const String _baseUrl = "https://api.themoviedb.org/3/movie";
  static const String _apiKey = "34738023d27013e6d1b995443764da44";

  Future<List<Movie>> fetchMovies(String endpoint) async {
    final url = Uri.parse("$_baseUrl/$endpoint?api_key=$_apiKey");

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final movieResult = MoviesResult.fromJson(jsonData);
        return movieResult.results;
      } else {
        throw Exception("Error del servidor: ${response.statusCode}");
      }
    } catch (e) {
      print("Error en MovieService: $e");
      rethrow;
    }
  }
}
