import 'package:flutter/material.dart';
import 'package:movies/models/main_result.dart';
import 'package:movies/modules/movies screens/Recommended/recommended_container.dart';
import 'package:movies/network/remote/api_manager.dart';
import 'package:movies/models/recommended_responce.dart';
import 'package:movies/mytheme/theme.dart';
import 'package:movies/screens/movie_detail_screen.dart';

class Recommended_api extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RecommendedMoviesResponse>(
      future: ApiManager.getRecommended(),
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
              ElevatedButton(onPressed: () {}, child: Text('Try again'))
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
        var resultList = snapshot.data?.results;
        return Container(
          margin: EdgeInsets.only(left: 15),
          padding: EdgeInsets.all(10),
          color: MyTheme.gray,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recommended',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 17),
              ),
              const SizedBox(height: 4),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, MovieDetailsScreen.ROUTENAME, arguments: MainResults.fromJson(resultList[index].toJson()));
                      },
                      child: Recommended_Container(
                          title: resultList![index].title!,
                          release: resultList[index].releaseDate!,
                          imagePath: resultList[index].posterPath ?? '',
                          vote: resultList[index].voteAverage!),
                    );
                  },
                  itemCount: resultList?.length,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
