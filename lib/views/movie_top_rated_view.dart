import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/MovieViewModel.dart'; // Importamos el nuevo ViewModel
import 'movie_detail_view.dart';

class MovieTopRatedView extends StatefulWidget {
  const MovieTopRatedView({super.key});

  @override
  State<MovieTopRatedView> createState() => _MovieTopRatedViewState();
}

class _MovieTopRatedViewState extends State<MovieTopRatedView> {
  @override
  void initState() {
    super.initState();
    // Cargamos específicamente Top Rated (isPopular: false)
    Future.microtask(
      () => context.read<MovieViewModel>().loadMovies(isPopular: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Escuchamos los cambios del ViewModel unificado
    final viewModel = context.watch<MovieViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Películas Mejor Valoradas"),
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: _buildGrid(viewModel),
    );
  }

  Widget _buildGrid(MovieViewModel viewModel) {
    // Usamos el flag específico de Top Rated para no interferir con Popular
    if (viewModel.isTopRatedLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.topRatedMovies.isEmpty) {
      return const Center(child: Text("No hay datos disponibles"));
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.68, // Ajustado para que quepa el texto debajo
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: viewModel.topRatedMovies.length,
        itemBuilder: (context, index) {
          final movie = viewModel.topRatedMovies[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailView(movie: movie),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Hero(
                      // Agregamos una animación Hero para el detalle
                      tag: 'top-${movie.id}',
                      child: movie.posterPath != null
                          ? Image.network(
                              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                              fit: BoxFit.cover,
                            )
                          : Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.movie, size: 40),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  movie.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      "${movie.voteAverage}",
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
