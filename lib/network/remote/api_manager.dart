import 'package:http/http.dart' as http;
import 'package:movies/models/image_response.dart';
import '../../models/popluar_movie_responce.dart';
import 'dart:convert';
import '../../models/details_resonce.dart';
import '../../models/recommended_responce.dart';
import '../../models/search_responce.dart';
import '../../models/upcomming_responce.dart';

class ApiManager {
  static const String baseUrl = 'api.themoviedb.org';
  static const String apiKey = 'de050c5fef6898173ea6490ff900b127';
  static String? baseImageUrl;

  static Future<SourcePopuler> getSources() async {
    var url = Uri.https(baseUrl, '/3/movie/popular', {
      'api_key': apiKey,
    });
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      var sourcePopular = SourcePopuler.fromJson(json);
      return sourcePopular;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<SourceUpcoming> getLatest() async {
    var url = Uri.https(baseUrl, '/3/movie/upcoming', {
      'api_key': apiKey,
    });
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      var sourceUpcoming = SourceUpcoming.fromJson(json);
      return sourceUpcoming;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<SourceRecommended> getRecommended() async {
    var url = Uri.https(baseUrl, '/3/movie/top_rated', {
      'api_key': apiKey,
    });
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      var sourceRecommended = SourceRecommended.fromJson(json);
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

  static Future<SourceSearchResponce> Search(String search) async {
    var url = Uri.https(
        baseUrl, '/3/search/movie', {'api_key': apiKey, 'query': search});
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      var search = SourceSearchResponce.fromJson(json);
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
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      var imageResponse = ImageResponse.fromJson(json);
      print(imageResponse);
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
}
