import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../services/movie_service.dart' as service_file;

class PopularViewModel extends ChangeNotifier {
  List<Movie> _articles = [];
  bool _isLoading = false;
  String _searchText = "";

  final service_file.WebServicesPopular _service =
      service_file.WebServicesPopular();

  List<Movie> get articles => _articles;
  bool get isLoading => _isLoading;

  List<Movie> get filteredArticles {
    if (_searchText.isEmpty) return _articles;
    return _articles
        .where((m) => m.title.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();
  }

  void setSearchText(String value) {
    _searchText = value;
    notifyListeners();
  }

  Future<void> fetchArticles() async {
    _isLoading = true;
    notifyListeners();

    final results = await _service.getArticles();
    if (results != null) {
      _articles = results;
    }

    _isLoading = false;
    notifyListeners();
  }
}
