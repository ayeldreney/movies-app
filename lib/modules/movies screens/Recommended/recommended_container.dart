import 'package:flutter/material.dart';

import 'package:movies/mytheme/theme.dart';
import 'package:movies/network/remote/api_manager.dart';
import 'package:movies/screens/movie_detail_screen.dart';

import '../../../models/recommended_responce.dart';
import 'Details_recomeded.dart';

class Recommended_Container extends StatelessWidget {
  String title;
  String imagePath;
  String release;
  num vote;
  Results results;

  Recommended_Container({
    required this.title,
    required this.release,
    required this.imagePath,
    required this.vote,
    required this.results,
  });

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Container(
        margin: EdgeInsets.all(8),
        color: MyTheme.Fontgray,
        width: mediaquery.width * 0.24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(Details_recomended.routeName,
                    arguments: results);
              },
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(8),
                    child: Image.network(
                        'https://image.tmdb.org/t/p/w500/${results.posterPath}',
                        height: mediaquery.height * 0.16),
                  ),
                  Image.asset(
                    'assets/images/bookmark.png',
                    height: 27,
                  )
                ],
              ),
            ),
            SizedBox(height: 2),
            Container(
              padding: EdgeInsets.only(left: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: MyTheme.yellow,
                        size: 16,
                      ),
                      SizedBox(width: 3),
                      Text(
                        '${results.voteAverage}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 8),
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    '${results.title}',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 13),
                  ),
                  SizedBox(height: 7),
                  Text(
                    '${results.releaseDate}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 10, color: Colors.white),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
