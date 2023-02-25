import 'package:flutter/material.dart';
import 'package:movies/models/main_result.dart';
import 'package:movies/modules/movies screens/Popular/popular_movies.dart';
import 'package:movies/network/remote/api_manager.dart';
import 'package:movies/models/popluar_movie_responce.dart';
import 'package:movies/mytheme/theme.dart';

class Popular_Container extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PopularMovieResponse>(
      future: ApiManager.getPopularMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
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
          return Column(
            children: [
              Text(snapshot.data?.StatusMessage ?? ''),
              ElevatedButton(onPressed: () {}, child: Text('Try again'))
            ],
          );
        }
//data
        List<Results>? resultList = snapshot.data?.results;
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Popular_Movie(
              results: MainResults.fromJson(resultList[index].toJson()),
            );
          },
          itemCount: resultList!.length,
        );
      },
    );
  }
}
