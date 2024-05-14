import 'package:flutter/material.dart';
import '../components/custom_button.dart';
import '../components/custom_image_slider.dart';
import '../models/movie_model.dart';
import '../services/UserService.dart';

class MovieInfo extends StatefulWidget {
  final Movie movie;
  final VoidCallback reloadPageCallback;

  const MovieInfo(
      {super.key, required this.movie, required this.reloadPageCallback});

  @override
  State<MovieInfo> createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  bool isInFavorites = false;

  @override
  void initState() {
    checkFavorites();
    super.initState();
  }

  Future<void> checkFavorites() async {
    UserService userService = UserService();
    String userKey = await userService.getUserKey();
    bool check = await userService.checkIfMovieIsInFavourites(widget.movie.id, userKey);
    setState(() {
      isInFavorites = check;
    });
  }

  void toggleFavorites() {
    setState(() {
      isInFavorites = !isInFavorites;
    });
  }

  void addOrDeleteFromFavourites() async {
    UserService userService = UserService();
    String userKey = await userService.getUserKey();
    if (!isInFavorites) {
      await userService.deleteFromFavourites(widget.movie.id, userKey);
    } else {
      await userService.addToFavourites(widget.movie.id, userKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    String buttonText = isInFavorites ?
    "Remove from favourites" :
    "Add to favourites";
    return PopScope(
      child: Dialog(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                  child: Text(
                    "${widget.movie.title} (${widget.movie.year})",
                    style: const TextStyle(fontSize: 22),
              )),
              CustomImageSlider(movie: widget.movie),
              Container(
                  padding: const EdgeInsets.all(5),
                  child: Text('Director: ${widget.movie.director}',
                    style: const TextStyle(fontSize: 18))),
              Container(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Text('Description: ${widget.movie.description}',
                      style: const TextStyle(fontSize: 18))),
              Container(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                  child: CustomButton(
                    onClick: () {
                      addOrDeleteFromFavourites();
                      toggleFavorites();
                    },
                    text: buttonText))
            ],
          ),
        ),
      ),
      onPopInvoked: (b) {
        widget.reloadPageCallback();
      },
    );
  }
}
