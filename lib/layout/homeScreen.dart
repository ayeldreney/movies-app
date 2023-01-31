import 'package:flutter/material.dart';
import 'package:movies/network/remote/api_manager.dart';

import '../models/popluarmovieresponce.dart';

class HomeScreen extends StatelessWidget {
  static const String ROUTENAME = "homescreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<PopluarMovieResponce>(
          future: ApiManager.getPopularMovies(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            return ListView.builder(
                itemBuilder: (context, index) =>
                    Text("${snapshot.data?.results?[index].id}"));
          },
        ));
  }
}
