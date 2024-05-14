import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/user_model.dart';

class UserService {
  final DatabaseReference database = FirebaseDatabase.instance.ref("users");

  Future<String> getUserKey() async {
    String userKey = "";
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && user.email != null) {
      DataSnapshot snapshot = await database.get();
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      values.forEach((key, value) {
        if (value["email"].toString() == user.email) {
          userKey = key;
          return;
        }
      });
    }
    return userKey;
  }

  Future<List<String>> getListOfFavourites(String userKey) async {
    DataSnapshot snapshot = await database.child(userKey).child("favourites").get();
    if (snapshot.value == null) {
      return [];
    }
    List<Object?> favourites = snapshot.value as List<Object?>;
    return favourites.map((e) => e as String).toList();
  }

  Future<void> addToFavourites(String id, String userKey) async {
    List<String> favourites = await getListOfFavourites(userKey);
    favourites.add(id);
    await database.child(userKey).child("favourites").set(favourites);
  }

  Future<void> deleteFromFavourites(String id, String userKey) async {
    List<String> favourites = await getListOfFavourites(userKey);
    favourites.remove(id);
    await database.child(userKey).child("favourites").set(favourites);
  }

  Future<bool> checkIfMovieIsInFavourites(String id, String userKey) async {
    List<String> favourites = await getListOfFavourites(userKey);
    return favourites.contains(id);
  }

  Future<void> saveChanges(DbUser user) async {
    String userKey = await getUserKey();
    await database.child(userKey).update({
      "firstName": user.firstName,
      "lastName": user.lastName,
      "gender": user.gender,
      "birthday": user.birthday,
      "phoneNumber": user.phoneNumber,
      "country": user.country,
      "favouriteGenre": user.favouriteGenre,
      "favouriteDirector": user.favouriteDirector,
      "bio": user.bio,
    });
  }

  Future<void> createUser(String email) async {
    await database.push().set({"email": email});
  }

  Future<DbUser> getFields() async {
    String userKey = await getUserKey();
    DataSnapshot snapshot = await database.child(userKey).get();
    Map<dynamic, dynamic> values = Map<dynamic, dynamic>.from(snapshot.value as dynamic);
    DbUser user = DbUser(
        email: values["email"],
        firstName: values["firstName"] ?? "",
        lastName: values["lastName"] ?? "",
        gender: values["gender"] ?? "",
        birthday: values["birthday"] ?? "",
        phoneNumber: values["phoneNumber"] ?? "",
        country: values["country"] ?? "",
        favouriteGenre: values["favouriteGenre"] ?? "",
        favouriteDirector: values["favouriteDirector"] ?? "",
        bio: values["bio"] ?? "",
        favorites: values["favorites"]
    );
    return user;
  }
}
