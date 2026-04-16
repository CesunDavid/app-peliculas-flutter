import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/movie.dart';
import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final api = ApiService();
  List<Movie> resultados = [];

  void buscar(String query) async {
    if (query.isEmpty) {
      setState(() {
        resultados = [];
      });
      return;
    }

    final res = await api.buscarPeliculas(query);

    setState(() {
      resultados = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Buscar")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              onChanged: buscar,
              decoration: InputDecoration(
                hintText: "Buscar película...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: resultados.length,
              itemBuilder: (context, index) {
                final movie = resultados[index];

                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: movie.poster.isNotEmpty
                        ? Image.network(
                            "https://image.tmdb.org/t/p/w200${movie.poster}",
                            width: 50,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.movie, size: 50),

                    title: Text(movie.title),
                    subtitle: Text("⭐ ${movie.rating}"),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(movieId: movie.id),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
