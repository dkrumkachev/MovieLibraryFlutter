import 'package:flutter/material.dart';
import '../components/custom_button.dart';
import '../components/custom_row.dart';
import '../models/user_model.dart';
import '../services/UserService.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController favouriteGenreController =
      TextEditingController();
  final TextEditingController favouriteDirectorController =
      TextEditingController();
  final TextEditingController bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fillFields();
  }

  Future<void> fillFields() async {
    UserService userService = UserService();
    DbUser user = await userService.getFields();
    setState(() {
      emailController.text = user.email;
      firstNameController.text = user.firstName;
      lastNameController.text = user.lastName;
      genderController.text = user.gender;
      birthdayController.text = user.birthday;
      phoneNumberController.text = user.phoneNumber;
      countryController.text = user.country;
      favouriteGenreController.text = user.favouriteGenre;
      favouriteDirectorController.text = user.favouriteDirector;
      bioController.text = user.bio;
    });
  }

  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void saveChanges() {
    UserService userService = UserService();
    DbUser updatedUser = DbUser(
        email: emailController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        gender: genderController.text,
        birthday: birthdayController.text,
        phoneNumber: phoneNumberController.text,
        country: countryController.text,
        favouriteGenre: favouriteGenreController.text,
        favouriteDirector: favouriteDirectorController.text,
        bio: bioController.text);
    userService.saveChanges(updatedUser);
    showSnackBar(context, 'Changes saved');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          CustomRow(
              controller: emailController,
              readOnly: true,
              hintText: emailController.text,
              labelText: 'Email:'),
          CustomRow(
              controller: firstNameController,
              hintText: firstNameController.text.isEmpty
                  ? 'Enter your first name'
                  : firstNameController.text,
              labelText: 'First name:'),
          CustomRow(
              controller: lastNameController,
              hintText: lastNameController.text.isEmpty
                  ? 'Enter your last name'
                  : lastNameController.text,
              labelText: 'Last name:'),
          CustomRow(
              controller: genderController,
              hintText: genderController.text.isEmpty
                  ? 'Enter your gender'
                  : genderController.text,
              labelText: 'Gender:'),
          CustomRow(
              controller: birthdayController,
              hintText: birthdayController.text.isEmpty
                  ? 'Enter your birthday'
                  : birthdayController.text,
              labelText: 'Birthday:'),
          CustomRow(
              controller: phoneNumberController,
              hintText: phoneNumberController.text.isEmpty
                  ? 'Enter your phone number'
                  : phoneNumberController.text,
              labelText: 'Phone number:'),
          CustomRow(
              controller: countryController,
              hintText: countryController.text.isEmpty
                  ? 'Enter your country'
                  : countryController.text,
              labelText: 'Country:'),
          CustomRow(
              controller: favouriteGenreController,
              hintText: favouriteGenreController.text.isEmpty
                  ? 'Enter your favourite genre'
                  : favouriteGenreController.text,
              labelText: 'Favourite genre:'),
          CustomRow(
              controller: favouriteDirectorController,
              hintText: favouriteDirectorController.text.isEmpty
                  ? 'Enter your favourite director'
                  : favouriteDirectorController.text,
              labelText: 'Favourite director:'),
          CustomRow(
              controller: bioController,
              hintText: bioController.text.isEmpty
                  ? 'Enter some info about yourself'
                  : bioController.text,
              labelText: 'Bio:'),
          Container(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: CustomButton(onClick: saveChanges, text: "Save changes"))
        ],
      ),
    ));
  }
}
