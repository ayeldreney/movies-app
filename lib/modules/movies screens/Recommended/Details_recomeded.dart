import 'package:flutter/material.dart';
import 'package:movies/layout/homeScreen.dart';
import 'package:movies/network/remote/api_manager.dart';

import '../../../models/details_resonce.dart';
import '../../../models/similiar.dart';
import '../../../mytheme/theme.dart';

class Details_recomended extends StatelessWidget {
  static String routeName = 'Details_Recomnded';

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
                Text('Something went wrong'),
                ElevatedButton(onPressed: () {}, child: Text('Try again'))
              ],
            );
          }
          if (snapshot.data?.Success == false) {
// server has code and message
            return Column(
              children: [
                Text(snapshot.data?.StatusMessage ?? ''),
                ElevatedButton(onPressed: () {}, child: Text('Try again'))
              ],
            );
          }
//data
          var details = snapshot.data!;
          var geners = snapshot.data!.genres ?? [];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                  'https://image.tmdb.org/t/p/w500/${details.backdropPath}'),
              Text(
                details.title ?? '',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              Text(
                details.releaseDate ?? '',
                style: TextStyle(color: Colors.white24, fontSize: 10),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Image.network(
                        'https://image.tmdb.org/t/p/w500/${details.posterPath}',
                        width: 100,
                        height: 150,
                      ),
                      Image.asset('assets/images/bookmark.png'),
                    ],
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    //flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Buttons(title: '${geners[0].name}'),
                          ],
                        ),
                        Text(
                          '${details.overview}',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Text(
                              '${details.voteAverage?.toStringAsFixed(1)}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                  flex: 1,
                  child: MoreLikeThis(
                    movieId: details.id ?? 0,
                  ))
            ],
          );
        },
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  String title;

  Buttons({required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        child: Text(
          '$title',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 13),
        ),
        style: ElevatedButton.styleFrom(
            side: BorderSide(color: MyTheme.gray),
            backgroundColor: Colors.transparent));
  }
}

class MoreLikeThis extends StatelessWidget {
  num movieId;

  MoreLikeThis({required this.movieId});

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    return FutureBuilder<SourceSimilar>(
      future: ApiManager.getSimilar(movieId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: MyTheme.orange,
          ));
        } else if (snapshot.hasError) {
          return Column(
            children: [
              Text('Something went wrong'),
              ElevatedButton(onPressed: () {}, child: Text('Trey again'))
            ],
          );
        }
        if (snapshot.data?.page != 1) {
// server has code and message
          return Column(
            children: [
              Text(snapshot.data?.StatusMessage ?? ''),
              ElevatedButton(onPressed: () {}, child: Text('Try again'))
            ],
          );
        }
//data
        var resultList = snapshot.data?.results ?? [];
        return Container(
          //margin: EdgeInsets.only(left: 15),
          padding: EdgeInsets.all(5),
          color: MyTheme.gray,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'More Like This',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 17),
              ),
              SizedBox(height: 4),
              Expanded(
                  child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return More_Like_Screen(results: resultList[index]);
                },
                itemCount: resultList.length,
              ))
            ],
          ),
        );
      },
    );
  }
}

class More_Like_Screen extends StatelessWidget {
  Results results;

  More_Like_Screen({required this.results});

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(Details_More_Like.routeName, arguments: results);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Container(
          margin: EdgeInsets.all(8),
          color: MyTheme.Fontgray,
          width: mediaquery.width * 0.24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
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
      ),
    );
  }
}

class Details_More_Like extends StatelessWidget {
  static String routeName = 'Details_Releases';

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
                Text('Something went wrong'),
                ElevatedButton(onPressed: () {}, child: Text('Try again'))
              ],
            );
          }
          if (snapshot.data?.Success == false) {
// server has code and message
            return Column(
              children: [
                Text(snapshot.data?.StatusMessage ?? ''),
                ElevatedButton(onPressed: () {}, child: Text('Try again'))
              ],
            );
          }
//data
          var details = snapshot.data!;
          var geners = snapshot.data!.genres ?? [];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                  'https://image.tmdb.org/t/p/w500/${details.backdropPath}'),
              Text(
                details.title ?? '',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              Text(
                details.releaseDate ?? '',
                style: TextStyle(color: Colors.white24, fontSize: 10),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Image.network(
                        'https://image.tmdb.org/t/p/w500/${details.posterPath}',
                        width: 100,
                        height: 150,
                      ),
                      Image.asset('assets/images/bookmark.png'),
                    ],
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    //flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Buttons(title: '${geners[0].name}'),
                          ],
                        ),
                        Text(
                          '${details.overview}',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Text(
                              '${details.voteAverage?.toStringAsFixed(1)}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                  flex: 1,
                  child: MoreLikeThis(
                    movieId: details.id ?? 0,
                  ))
            ],
          );
        },
      ),
    );
  }
}
