import 'package:http/http.dart' as http;
import 'package:movies/models/category_data.dart';
import 'package:movies/models/genre_movie_response.dart';
import 'package:movies/models/image_response.dart';
import '../../models/popluar_movie_responce.dart';
import 'dart:convert';
import '../../models/details_resonce.dart';
import '../../models/recommended_responce.dart';
import '../../models/search_response.dart';
import '../../models/upcoming_movie_response.dart';

class ApiManager {
  static const String baseUrl = 'api.themoviedb.org';
  static const String apiKey = 'de050c5fef6898173ea6490ff900b127';
  static String? baseImageUrl;

  static Future<PopularMovieResponse> getPopularMovies() async {
    var url = Uri.https(baseUrl, '/3/movie/popular', {
      'api_key': apiKey,
    });
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      var sourcePopular = PopularMovieResponse.fromJson(json);
      return sourcePopular;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<UpcomingMovieResponse> getLatest() async {
    var url = Uri.https(baseUrl, '/3/movie/upcoming', {
      'api_key': apiKey,
    });
    try {
      var response = await http.get(url);
      print(response.body);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      var sourceUpcoming = UpcomingMovieResponse.fromJson(json);
      return sourceUpcoming;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<RecommendedMoviesResponse> getRecommended() async {
    var url = Uri.https(baseUrl, '/3/movie/top_rated', {
      'api_key': apiKey,
    });
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      var sourceRecommended = RecommendedMoviesResponse.fromJson(json);
      return sourceRecommended;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<SourceDetails> getDetails(num movieId) async {
    var url = Uri.https(baseUrl, '/3/movie/$movieId', {
      'api_key': apiKey,
    });
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      var sourceDetails = SourceDetails.fromJson(json);
      return sourceDetails;
    } catch (e) {
      print(e);
      rethrow;
    }
  }


  static Future<SearchResponse> querySearch(String search) async {
    var url = Uri.https(baseUrl, '/3/search/movie', {
      'api_key': apiKey,
      'query': search,
    });
    try {
      var response = await http.get(url);
      print(response.body);
      print("---------------------------------------------------");
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      var search = SearchResponse.fromJson(json);
      return search;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<genreMovieResponse> idSearch(int? id) async {
    var url = Uri.https(baseUrl, '/3/discover/movie', {
      'api_key': apiKey,
      'sort_by': 'popularity.desc',
      'include_video': "false",
      'with_genres': "$id",
    });
    try {
      var response = await http.get(url);
      print(response.body);
      print("---------------------------------------------------");
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      var search = genreMovieResponse.fromJson(json);
      return search;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<ImageResponse> getImageInfo() async {
    var url = Uri.https(baseUrl, '/3/configuration', {'api_key': apiKey});
    try {
      var response = await http.get(url);
      print(response.statusCode);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      var imageResponse = ImageResponse.fromJson(json);
      return imageResponse;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<void> getImageBaseUrl() async {
    ImageResponse imageResponse = await getImageInfo();
    baseImageUrl = imageResponse.images?.secureBaseUrl;
  }

  static Future<GenreResponse> getGenres() async {
    var url = Uri.https(baseUrl, '/3/genre/movie/list', {'api_key': apiKey});
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      var genresResponse = GenreResponse.fromJson(json);
      return genresResponse;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
