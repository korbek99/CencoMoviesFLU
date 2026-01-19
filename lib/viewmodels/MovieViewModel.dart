import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../services/MovieService.dart' as api;

class MovieViewModel extends ChangeNotifier {
  // Instanciamos el servicio nuevo
  final api.MovieService _service = api.MovieService();

  // Listas de datos
  List<Movie> popularMovies = [];
  List<Movie> topRatedMovies = [];

  // Estados de carga
  bool isPopularLoading = false;
  bool isTopRatedLoading = false;

  // Manejo de errores
  String? errorMessage;

  // Método funcional: Carga películas según el tipo
  Future<void> loadMovies({required bool isPopular}) async {
    _setLoading(isPopular, true);
    errorMessage = null;
    notifyListeners();

    try {
      final endpoint = isPopular ? 'popular' : 'top_rated';
      final results = await _service.fetchMovies(endpoint);

      if (isPopular) {
        popularMovies = results;
      } else {
        topRatedMovies = results;
      }
    } catch (e) {
      errorMessage = "No se pudieron cargar las películas.";
    } finally {
      _setLoading(isPopular, false);
      notifyListeners();
    }
  }

  void _setLoading(bool isPopular, bool value) {
    if (isPopular) {
      isPopularLoading = value;
    } else {
      isTopRatedLoading = value;
    }
  }

  // Lógica de filtrado (Search) para la vista popular
  List<Movie> getFilteredPopular(String query) {
    if (query.isEmpty) return popularMovies;
    return popularMovies
        .where((m) => m.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
