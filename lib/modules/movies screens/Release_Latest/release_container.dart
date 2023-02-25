import 'package:flutter/material.dart';
import 'package:movies/models/movie_data.dart';
import 'package:movies/network/remote/api_manager.dart';
import 'package:movies/network/remote/firebase_utils.dart';
import 'package:movies/screens/movie_detail_screen.dart';

class ReleasesContainer extends StatefulWidget {
  String imagePath;
  MovieData favouriteMovie;
<<<<<<< HEAD

  ReleasesContainer(
      {required this.imagePath,
      required this.favouriteMovie,
      this.favourite = false});
=======
  bool favourite = false;
  ReleasesContainer({required this.imagePath, required this.favouriteMovie});
>>>>>>> f597d5e4f6a3dbb23b9b0ecf439ef2e71cc6938b

  @override
  State<ReleasesContainer> createState() => _ReleasesContainerState();
}

class _ReleasesContainerState extends State<ReleasesContainer> {
  @override
  void initState() {
    widget.favourite = widget.favouriteMovie.wishlisted ?? false;
    super.initState();
  }
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
<<<<<<< HEAD
            widget.favourite = true;
            addFavouriteMovieToDatabase(widget.favouriteMovie);
            setState(() {});
=======
            if(!widget.favourite){
              widget.favourite = true;
              widget.favouriteMovie.wishlisted=true;
              addFavouriteMovieToDatabase(widget.favouriteMovie);
            }else {
              widget.favourite = false;
              deleteMovieFromFirebase(widget.favouriteMovie.title);
            }
            setState(() {

            });
>>>>>>> f597d5e4f6a3dbb23b9b0ecf439ef2e71cc6938b
          },
          child: Image.asset(
            !widget.favourite
                ? 'assets/images/bookmark.png'
                : 'assets/images/favourite.png',
            height: 27,
          ),
        )
      ],
    );
  }
}
