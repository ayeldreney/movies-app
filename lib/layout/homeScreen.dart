import 'package:flutter/material.dart';
import 'package:movies/screens/searchScreen.dart';
import 'package:movies/screens/watchlist_screen/watchlist_screen.dart';

import 'package:movies/list_of_movies.dart';
import 'package:movies/mytheme/theme.dart';

import 'package:movies/screens/browse_category_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String ROUTENAME = "homescreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentindex = 0;

  List<Widget> tabs = [
    ListOfMovies(),
    Search(),
    BrowseCategoryScreen(),
    WatchListScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentindex],
      backgroundColor: Colors.transparent,
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: MyTheme.iconcolorBar,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: MyTheme.colorBar,
        fixedColor: MyTheme.yellow,
        currentIndex: currentindex,
        onTap: (value) {
          currentindex = value;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/browse.png')),
            label: 'Browse',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/watchlist.png')),
            label: 'WatchList',
          ),
        ],
      ),
    );
  }
}
