import 'dart:convert';

class MoviesResult {
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  MoviesResult({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  // Este es el equivalente al "Decodable" de Swift
  factory MoviesResult.fromJson(Map<String, dynamic> json) => MoviesResult(
    page: json["page"],
    results: List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );
}

class Movie {
  final bool adult;
  final String? backdropPath; // Puede ser nulo
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath; // Puede ser nulo
  final String releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Movie({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  // Equivalente a CodingKeys en Swift
  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    adult: json["adult"] ?? false,
    backdropPath: json["backdrop_path"],
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"],
    originalLanguage: json["original_language"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble() ?? 0.0,
    posterPath: json["poster_path"],
    releaseDate: json["release_date"] ?? "",
    title: json["title"],
    video: json["video"] ?? false,
    voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
    voteCount: json["vote_count"] ?? 0,
  );
}
