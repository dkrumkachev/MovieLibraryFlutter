class DbUser {
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String birthday;
  final String phoneNumber;
  final String country;
  final String favouriteGenre;
  final String favouriteDirector;
  final String bio;
  final List<String>? favorites;


  DbUser({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.birthday,
    required this.phoneNumber,
    required this.country,
    required this.favouriteGenre,
    required this.favouriteDirector,
    required this.bio,
    this.favorites
  });
}