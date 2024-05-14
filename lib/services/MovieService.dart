import "package:firebase_core/firebase_core.dart";
import "package:firebase_database/firebase_database.dart";
import "../models/movie_model.dart";
import 'package:firebase_storage/firebase_storage.dart';

class MovieService{
  final DatabaseReference database = FirebaseDatabase.instance.ref("movies");
  MovieService();

  Future<List<Movie>> getMovies() async {
    List<Movie> movies = [];
    DataSnapshot snapshot = await database.get();
    Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
    values.forEach((key, value) {

      Movie movie = Movie(
          id: value["id"],
          title: value["title"],
          description: value["description"],
          director: value["director"],
          year: value["year"],
          images: List.empty(growable: true)
      );
      for (Object? imageUrl in value["images"] as List<Object?>) {
        movie.images.add(imageUrl as String);
      }
      movies.add(movie);
    });
    return movies;
  }

  Future<List<Movie>> getMoviesWithIds(List<String> ids) async {
    List<Movie> movies = await getMovies();
    List<Movie> result = List.empty(growable: true);
    for (Movie movie in movies){
      if (ids.contains(movie.id)) {
        result.add(movie);
      }
    }
    return result;
  }
}