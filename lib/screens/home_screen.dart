import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/movie.dart';
import 'detail_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final api = ApiService();
  late Future<List<Movie>> peliculas;

  @override
  void initState() {
    super.initState();
    peliculas = api.obtenerPeliculas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //
        title: const Text("Películas populares"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Movie>>(
        future: peliculas,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final lista = snapshot.data!;

          return ListView.builder(
            itemCount: lista.length,
            itemBuilder: (context, index) {
              final movie = lista[index];

              return ListTile(
                leading: Image.network(
                  "https://image.tmdb.org/t/p/w200${movie.poster}",
                  width: 50,
                ),
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
              );
            },
          );
        },
      ),
    );
  }
}
