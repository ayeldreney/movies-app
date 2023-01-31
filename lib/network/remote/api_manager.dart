import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/models/popluarmovieresponce.dart';

class ApiManager {
  static const String BASEURL = 'api.themoviedb.org';

  static Future<PopluarMovieResponce> getPopularMovies() async {
    var url = Uri.https(BASEURL, "/3/movie/popular",
        {"api_Key": "de050c5fef6898173ea6490ff900b127"});

    var response = await http.get(url);
    var json = jsonDecode(response.body);
    PopluarMovieResponce popluarMovieResponce =
        PopluarMovieResponce.fromJson(json);

    return popluarMovieResponce;
  }
}
