import 'package:flutter/material.dart';
import 'package:movies/models/popluar_movie_responce.dart';
import 'package:movies/network/remote/api_manager.dart';

import 'package:movies/layout/homeScreen.dart';

import 'package:movies/models/details_resonce.dart';
import 'package:movies/mytheme/theme.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const String ROUTENAME = 'moviescreenDetails';
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as Results;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          args.title ?? '',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(HomeScreen.ROUTENAME);
          },
        ),
        backgroundColor: Colors.white12,
        elevation: 0,
        centerTitle: true,
      ),
      body: FutureBuilder<SourceDetails>(
        future: ApiManager.getDetails(args.id ?? 0),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: MyTheme.orange,
            ));
          } else if (snapshot.hasError) {
            return Column(
              children: [
                const Text('Something went wrong'),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('try again'),
                ),
              ],
            );
          }
          if (snapshot.data?.Success == false) {
// server has code and message
            return Column(
              children: [
                Text(snapshot.data?.StatusMessage ?? ''),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Try again'),
                ),
              ],
            );
          }

          var details = snapshot.data!;
          var geners = snapshot.data!.genres ?? [];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                  'https://image.tmdb.org/t/p/w500/${details.backdropPath}'),
              SizedBox(
                height: 10,
              ),
              Text(
                details.title ?? '',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                details.releaseDate ?? '',
                style: TextStyle(color: Colors.white24),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Image.network(
                        'https://image.tmdb.org/t/p/w500/${details.posterPath}',
                        width: 100,
                        height: 200,
                      ),
                      Image.asset('assets/images/bookmark.png'),
                    ],
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    "",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent)),
                            ],
                          ),
                          MaterialButton(
                            color: MyTheme.colorBar,
                            onPressed: () {},
                            child: Text(
                              geners[0].name.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            child: Text(
                              details.overview.toString(),
                            ),
                          ),
                          Text(
                            details.voteAverage.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Text(
                                '',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              MoreLikeThisScreen(),
            ],
          );
        },
      ),
    );
  }
}

class MoreLikeThisScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    return Expanded(
      flex: 2,
      child: Container(
        margin: EdgeInsets.only(left: 15),
        padding: EdgeInsets.all(10),
        color: MyTheme.gray,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'More Like This',
              style:
                  Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 17),
            ),
            SizedBox(height: 4),
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      color: MyTheme.Fontgray,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Image.asset('assets/images/image_film.png',
                                  height: mediaquery.height * 0.16),
                              Image.asset(
                                'assets/images/bookmark.png',
                                height: 27,
                              )
                            ],
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
                                      '7.7',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(fontSize: 12),
                                    )
                                  ],
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Dora',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(fontSize: 13),
                                ),
                                SizedBox(height: 7),
                                Text(
                                  '2018 R 1h 59m',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          fontSize: 10, color: Colors.white),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: 15,
                separatorBuilder: (context, index) {
                  return SizedBox(width: 13);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
