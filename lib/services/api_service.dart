import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class ApiService {
  final String apiKey = "34b45bccebe5c9ad8ac29899a97d2379";

  Future<List<Movie>> obtenerPeliculas() async {
    final url = Uri.parse(
      "https://api.themoviedb.org/3/movie/popular?api_key=$apiKey",
    );

    final response = await http.get(url);
    final data = json.decode(response.body);

    return (data['results'] as List).map((e) => Movie.fromJson(e)).toList();
  }

  Future<List<Movie>> buscarPeliculas(String query) async {
    final url = Uri.parse(
      "https://api.themoviedb.org/3/search/movie?query=$query&api_key=$apiKey",
    );

    final response = await http.get(url);
    final data = json.decode(response.body);

    return (data['results'] as List).map((e) => Movie.fromJson(e)).toList();
  }
}
