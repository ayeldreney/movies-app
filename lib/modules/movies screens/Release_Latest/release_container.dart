import 'package:flutter/material.dart';
import 'package:movies/models/movie_data.dart';
import 'package:movies/network/remote/api_manager.dart';
import 'package:movies/network/remote/firebase_utils.dart';

class ReleasesContainer extends StatefulWidget {
  String imagePath;
  bool favourite;
  MovieData favouriteMovie;

  ReleasesContainer({required this.imagePath, required this.favouriteMovie, this.favourite = false});

  @override
  State<ReleasesContainer> createState() => _ReleasesContainerState();
}

class _ReleasesContainerState extends State<ReleasesContainer> {
  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(9),
          child: Container(
            margin: EdgeInsets.all(8),
            child: Image.network(
              '${ApiManager.baseImageUrl}w500/${widget.imagePath}',
              height: mediaquery.height * 0.2,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            widget.favourite = true;
            addFavouriteMovieToDatabase(widget.favouriteMovie);
            setState(() {

            });
          },
          child: Image.asset(
            !widget.favourite?'assets/images/bookmark.png': 'assets/images/favourite.png',
            height: 27,
          ),
        )
      ],
    );
  }
}
