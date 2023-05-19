import 'package:flutter/material.dart';
import 'package:swifty_companion/models/coalition.model.dart';
import 'package:swifty_companion/models/user.model.dart';
import 'package:swifty_companion/views/profile/profile_user.dart';
import 'package:swifty_companion/views/search_user/index.dart';

class HomeScreen extends StatefulWidget {
  final User currentUser;
  final Coalition userCoalition;
  const HomeScreen(
      {Key? key, required this.currentUser, required this.userCoalition})
      : super(key: key);

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState(currentUser: currentUser, userCoalition: userCoalition);
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final User currentUser;
  final Coalition userCoalition;

  _HomeScreenState({required this.currentUser, required this.userCoalition});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swifty Companion'),
      ),
      body: Center(
        child: currentIndex == 0
            ? ProfileView(
                currentUser: currentUser, userCoalition: userCoalition)
            : const SearchUserView(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}
