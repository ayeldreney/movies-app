import 'package:flutter/material.dart';
import 'package:movies/models/category_data.dart';
import 'package:movies/models/main_result.dart';
import 'package:movies/network/remote/api_manager.dart';
import 'package:movies/screens/genre_movies//movie_item.dart';

class GenreMovies extends StatelessWidget {


  static const String ROUTENAME = "genre_movies_screen";

  @override
  Widget build(BuildContext context) {
    Genres genre = ModalRoute.of(context)?.settings.arguments as Genres;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            FutureBuilder(
              future: ApiManager.idSearch(genre.id),
              builder: (context, snapshot) {
                print(genre.name!);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text("${snapshot.error}"),
                  );
                }
                if (snapshot.data!.results!.isEmpty) {
                  return const Center(
                    child: Text(
                      "no results",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  );
                }
                var items = snapshot.data?.results;
                return Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Color.fromRGBO(112, 112, 112, 1.0),
                      );
                    },
                    itemCount: items!.length,
                    itemBuilder: (context, index) => MovieItem(resultMovie: MainResults.fromJson(items[index].toJson()),),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
