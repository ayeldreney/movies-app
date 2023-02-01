import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/models/movie_data.dart';
import 'package:movies/network/remote/api_manager.dart';
import 'package:movies/network/remote/firebase_utils.dart';

class MovieItem extends StatelessWidget {
  MovieData movieData;
  MovieItem(this.movieData);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl: "${ApiManager.baseImageUrl}w500${movieData.posterPath}",
                errorWidget: (context, url, error) {
                  return const Text("Image not Available");
                },
                alignment: Alignment.centerLeft,
                width: MediaQuery.of(context).size.width*0.3,
                height: MediaQuery.of(context).size.height*0.2,
              ),
              InkWell(
                onTap: () async{
                  await deleteMovieFromFirebase(movieData.title);
                },
                child: Image.asset("assets/images/favourite.png"),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${movieData.title}",
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text("${movieData.releaseDate}", textAlign: TextAlign.start),
              ],
            ),
          )
        ],
      ),
    );
  }
}
