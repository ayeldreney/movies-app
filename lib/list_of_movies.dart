import 'package:flutter/material.dart';
import 'package:movies/modules/movies screens/Recommended/recommended_api.dart';
import 'package:movies/modules/movies%20screens/Popular/popular_api.dart';
import 'package:movies/modules/movies screens/Release_Latest/release_api.dart';

class ListOfMovies extends StatefulWidget {
  @override
  State<ListOfMovies> createState() => _Home_MovieState();
}

class _Home_MovieState extends State<ListOfMovies> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          child: Column(
        children: [
          Expanded(flex: 2, child: Popular_Container()),
          Expanded(flex: 1, child: Release_Latest()),
          Expanded(flex: 2, child: Recommended_api())
        ],
      )),
    );
  }
}
