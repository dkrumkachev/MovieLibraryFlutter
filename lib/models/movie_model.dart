class Movie {
  final String id;
  final String description;
  final String director;
  final String title;
  final int year;
  final List<String> images;
  bool isInFavourites = false;

  Movie({
    required this.id,
    required this.description,
    required this.director,
    required this.title,
    required this.year,
    required this.images
  });
}