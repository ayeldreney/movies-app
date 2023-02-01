import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/models/main_result.dart';
import 'package:movies/network/remote/api_manager.dart';
import 'package:movies/screens/movie_detail_screen.dart';

class MovieItem extends StatelessWidget {

  MainResults resultMovie;


  MovieItem({required this.resultMovie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      //details item
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, MovieDetailsScreen.ROUTENAME, arguments: resultMovie);
        },
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: "${ApiManager.baseImageUrl}w500${resultMovie.posterPath}",
              errorWidget: (context, url, error) {
                return const Text("Image not Available");
              },
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width*0.3,
              height: MediaQuery.of(context).size.height*0.2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150,
                    child: Text(
                      "${resultMovie.title}",
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  Text("${resultMovie.releaseDate}", textAlign: TextAlign.start),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
