import 'package:flutter/material.dart';

import 'package:movies/models/popluar_movie_responce.dart';
import 'package:movies/network/remote/api_manager.dart';
import 'package:movies/network/remote/firebase_utils.dart';
import 'package:movies/screens/movie_detail_screen.dart';

class Popular_Movie extends StatelessWidget {
  Results results;

  Popular_Movie({required this.results});

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(MovieDetailsScreen.ROUTENAME, arguments: results);
      },
      child: Container(
          margin: EdgeInsets.all(10),
          child: Stack(
            children: [
              Image.network(
                '${ApiManager.baseImageUrl}w500${results.backdropPath}',
                height: mediaquery.height * 0.26,
              ),
              Positioned(
                  top: 80,
                  left: 13,
                  child: Stack(
                    children: [
                      Image.network(
                        '${ApiManager.baseImageUrl}w500/${results.posterPath}',
                        height: mediaquery.height * 0.23,
                      ),
                      Image.asset('assets/images/bookmark.png',)
                    ],
                  )),
              Positioned(
                top: mediaquery.height * 0.26,
                left: mediaquery.width * 0.38,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      results.title ?? '',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Released Date: ${results.releaseDate}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white54),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
