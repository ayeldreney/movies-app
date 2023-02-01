import 'package:flutter/material.dart';
import 'package:movies/models/movie_data.dart';
import 'package:movies/modules/movies screens/Release_Latest/release_container.dart';
import 'package:movies/network/remote/api_manager.dart';
import 'package:movies/models/upcomming_responce.dart';
import 'package:movies/mytheme/theme.dart';
import 'package:movies/screens/movie_detail_screen.dart';

class ReleaseLatest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourceUpcoming>(
      future: ApiManager.getLatest(),
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
              ElevatedButton(onPressed: () {}, child: const Text('Try again'))
            ],
          );
        }
        if (snapshot.data?.page != 1) {
// server has code and message
          return Column(
            children: [
              Text(snapshot.data?.StatusMessage ?? ''),
              ElevatedButton(onPressed: () {}, child: const Text('Try again'))
            ],
          );
        }
//data
        var resultList = snapshot.data?.results ?? [];
        return Container(
            margin: const EdgeInsets.only(left: 13, bottom: 5),
            padding: const EdgeInsets.all(10),
            color: MyTheme.gray,
            width: double.infinity,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'New Releases',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 17),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, MovieDetailsScreen.ROUTENAME);
                      },
                      child: ReleasesContainer(
                          imagePath: resultList[index].posterPath ?? '',
                          favouriteMovie: onMovieFavourite(resultList[index])),
                    );
                  },
                  itemCount: resultList.length,
                ),
              )
            ]));
      },
    );
  }

  MovieData onMovieFavourite(Results addedMovie) {
    Map<String, dynamic> tmpmap = {
      "title": addedMovie.title,
      "releaseDate": addedMovie.releaseDate,
      "posterPath": "${ApiManager.baseImageUrl}/w500/${addedMovie.posterPath}",
    };
    MovieData movieData = MovieData.fromJson(tmpmap);
    return movieData;
  }
}
