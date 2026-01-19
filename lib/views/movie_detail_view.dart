import 'package:flutter/material.dart';
import '../models/movie_model.dart';

class MovieDetailView extends StatelessWidget {
  final Movie movie;

  const MovieDetailView({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (movie.backdropPath != null)
              Image.network(
                'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Estreno: ${movie.releaseDate}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(movie.overview, style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
