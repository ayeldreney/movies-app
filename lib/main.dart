import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies/layout/homeScreen.dart';
import 'package:movies/screens/genre_movies/genre_movies.dart';
import 'package:movies/screens/movie_detail_screen.dart';
import 'package:movies/network/remote/api_manager.dart';

import 'mytheme/theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseFirestore.instance.disableNetwork();
  await ApiManager.getImageBaseUrl();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyTheme.DarkMode,
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.ROUTENAME,
      routes: {
        HomeScreen.ROUTENAME: (context) => HomeScreen(),
        MovieDetailsScreen.ROUTENAME: (context) => MovieDetailsScreen(),
        GenreMovies.ROUTENAME: (context) => GenreMovies(),
      },
    );
  }
}
