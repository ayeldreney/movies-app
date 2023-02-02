import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/models/main_result.dart';
import 'package:movies/network/remote/api_manager.dart';
import 'package:movies/models/details_resonce.dart';
import 'package:movies/mytheme/theme.dart';
import 'package:movies/screens/genre_movies/movie_item.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const String ROUTENAME = 'moviescreenDetails';

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as MainResults;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          args.title ?? '',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white12,
        elevation: 0,
        centerTitle: true,
      ),
      body: FutureBuilder<SourceDetails>(
        future: ApiManager.getDetails(args.id ?? 0),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
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
          var genres = snapshot.data!.genres ?? [];
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                    imageUrl:
                        '${ApiManager.baseImageUrl}w500/${details.backdropPath}'),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  details.title!,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  details.releaseDate!,
                  style: const TextStyle(color: Colors.white24),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Stack(
                          children: [
                            Image.network(
                              '${ApiManager.baseImageUrl}w500/${details.posterPath}',
                              width: 100,
                              height: 150,
                            ),
                            Image.asset('assets/images/bookmark.png'),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            MaterialButton(
                              color: MyTheme.colorBar,
                              onPressed: () {},
                              child: Text(
                                genres[0].name.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),),
                              const SizedBox(
                                width: 5,
                              )
                              ,MaterialButton(
                              color: MyTheme.colorBar,
                              onPressed: () {},
                              child: Text(
                                genres[1].name.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),)
                          ],
                        ),

                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            details.overview.toString(),
                            style: const TextStyle(
                              color: Colors.white
                            ),
                          ),
                        ),
                        Row(
                          children:  [
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Text(
                              details.voteAverage.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
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
    return SizedBox(
      width: mediaquery.width*0.5,
      height: mediaquery.height*0.3,
      child: Row(
        children: [
          Text("More Like This"),
          SizedBox(height: 10,),
          FutureBuilder(future: ApiManager.getRecommended(),builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if(snapshot.hasError){
              return Center(child: Text("${snapshot.error}"),);
            }
            if(snapshot.data?.page!=1){
              return Center(child: Text("Something went wrong"),);
            }
            var recoList = snapshot.data?.results;
            return Expanded(
              child: ListView.builder(scrollDirection: Axis.horizontal,itemBuilder: (context, index) {
                return MovieItem(resultMovie: MainResults.fromJson(recoList[index].toJson()));
              }, itemCount: recoList!.length),
            );
          },),
        ],
      ),
    );
  }
}
