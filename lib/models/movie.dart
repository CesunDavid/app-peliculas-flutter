class Movie {
  final int id;
  final String title;
  final String poster;
  final double rating;

  Movie({
    required this.id,
    required this.title,
    required this.poster,
    required this.rating,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'] ?? '',
      poster: json['poster_path'] ?? '',
      rating: (json['vote_average'] ?? 0).toDouble(),
    );
  }
}
