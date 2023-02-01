import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies/layout/homeScreen.dart';
import 'package:movies/provider/bot_nav_bar_provider.dart';
import 'package:movies/screens/movie_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:movies/network/remote/api_manager.dart';

import 'mytheme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ApiManager.getImageBaseUrl();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BotNavBarProvider(),
        ),
      ],
      child: MaterialApp(
        theme: MyTheme.DarkMode,
        debugShowCheckedModeBanner: false,
        initialRoute: HomeScreen.ROUTENAME,
        routes: {
          HomeScreen.ROUTENAME: (context) => HomeScreen(),
          MovieDetailsScreen.ROUTENAME: (context) => MovieDetailsScreen(),
        },
      ),
    );
  }
}
