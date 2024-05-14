import 'package:flutter/material.dart';
import '../services/AuthService.dart';
import 'account_page.dart';
import 'favourites_page.dart';
import 'movies_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  void signOut() async{
    final authService = AuthService();
    authService.signOut();
  }

  final pages = [
    const MoviesPage(),
    const FavouritesPage(),
    const AccountPage(),
    null,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Movies")),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 18,
        unselectedFontSize: 16,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Movies",
            backgroundColor: Colors.blueAccent
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favourites",
            backgroundColor: Colors.blueAccent
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
            backgroundColor: Colors.blueAccent
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: "Sign out",
            backgroundColor: Colors.blueAccent
          ),
        ],
        onTap: (index){
          if (index == 3){
            final authService = AuthService();
            authService.signOut();
          }
          else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
      ),
    );
  }
}
