import 'package:flutter/material.dart';

import '../models/movie_model.dart';
import '../services/MovieService.dart';
import '../services/UserService.dart';
import 'movie_info_page.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  List<Movie> movieList = [];

  void reloadPageCallback() {
    setState(() {
      loadMovies();
    });
  }
  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  Future<void> loadMovies() async {
    UserService userService = UserService();
    String userKey = await userService.getUserKey();
    List<String> favourites = await userService.getListOfFavourites(userKey);
    if(favourites.isNotEmpty) {
      MovieService movieService = MovieService();
      List<Movie> items = await movieService.getMoviesWithIds(favourites);
      setState(() {
        movieList = items;
      });
    }
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
