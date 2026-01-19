import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/MovieViewModel.dart'; // Importamos el nuevo ViewModel
import 'movie_detail_view.dart'; // Asegúrate de tener esta vista creada

class MoviePopularView extends StatefulWidget {
  const MoviePopularView({super.key});

  @override
  State<MoviePopularView> createState() => _MoviePopularViewState();
}

class _MoviePopularViewState extends State<MoviePopularView> {
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    // Llamamos al nuevo método funcional con isPopular: true
    Future.microtask(
      () => context.read<MovieViewModel>().loadMovies(isPopular: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Escuchamos el nuevo ViewModel
    final viewModel = context.watch<MovieViewModel>();

    // Obtenemos la lista filtrada usando el método del ViewModel
    final movies = viewModel.getFilteredPopular(_searchQuery);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Películas Populares"),
        backgroundColor: Colors.yellow,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Buscar en populares...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: _buildBody(viewModel, movies),
    );
  }

  Widget _buildBody(MovieViewModel viewModel, List movies) {
    if (viewModel.isPopularLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.errorMessage != null && movies.isEmpty) {
      return Center(child: Text(viewModel.errorMessage!));
    }

    if (movies.isEmpty) {
      return const Center(child: Text("No se encontraron resultados"));
    }

    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          elevation: 2,
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: movie.posterPath != null
                  ? Image.network(
                      'https://image.tmdb.org/t/p/w92${movie.posterPath}',
                      width: 50,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: 50,
                      color: Colors.grey,
                      child: const Icon(Icons.movie),
                    ),
            ),
            title: Text(
              movie.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("⭐ ${movie.voteAverage}"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
            onTap: () {
              // Navegación al detalle
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailView(movie: movie),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
