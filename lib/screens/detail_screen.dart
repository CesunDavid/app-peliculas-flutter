import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailScreen extends StatefulWidget {
  final int movieId;

  const DetailScreen({super.key, required this.movieId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Map<String, dynamic>? movie;

  final String apiKey = "34b45bccebe5c9ad8ac29899a97d2379";

  @override
  void initState() {
    super.initState();
    obtenerDetalle();
  }

  Future<void> obtenerDetalle() async {
    final url = Uri.parse(
      "https://api.themoviedb.org/3/movie/${widget.movieId}?api_key=$apiKey",
    );

    final response = await http.get(url);
    final data = json.decode(response.body);

    setState(() {
      movie = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (movie == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Cargando...")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(movie!['title'])),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              "https://image.tmdb.org/t/p/w500${movie!['poster_path'] ?? ''}",
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(movie!['overview']),
            ),
            Text("⭐ ${movie!['vote_average']}"),
            Text("📅 ${movie!['release_date']}"),
          ],
        ),
      ),
    );
  }
}
