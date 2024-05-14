import 'dart:async';
import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../services/MovieService.dart';
import 'movie_info_page.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  List<Movie> movieList = [];

  void reloadPageCallback() {}

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  Future<void> loadMovies() async {
    MovieService movieService = MovieService();
    List<Movie> items = await movieService.getMovies();
    setState(() {
      movieList = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: movieList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(movieList[index].title,
                style: const TextStyle(fontSize: 20)),
            subtitle: Text(movieList[index].year.toString(),
                style: const TextStyle(fontSize: 20)),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return MovieInfo(
                    movie: movieList[index],
                    reloadPageCallback: reloadPageCallback);
                });
            },
          );
        },
      ),
    );
  }
}
