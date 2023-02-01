import 'package:flutter/material.dart';
import 'package:movies/models/category_data.dart';
import 'package:movies/screens/genre_movies/genre_movies.dart';

class CategoryCard extends StatelessWidget {
  String imgPath;
  Genres? genre;

  CategoryCard({this.imgPath = "assets/images/general.png", this.genre});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.02,
            right: MediaQuery.of(context).size.width * 0.02,
            top: MediaQuery.of(context).size.height * 0.01,
            bottom: MediaQuery.of(context).size.height * 0.01),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, GenreMovies.ROUTENAME,
                arguments: genre);
          },
          child: Stack(
            children: [
              Image.asset(
                imgPath,
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              Center(
                child: Text(
                  genre?.name ?? "Unavailable",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ],
          ),
        ));
  }
}
