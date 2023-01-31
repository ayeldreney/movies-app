import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies/models/movie_data.dart';

CollectionReference<MovieData> getFavouriteMoviesCollection() =>
    FirebaseFirestore.instance.collection("movies").withConverter<MovieData>(
        fromFirestore: (snapshot, options) {
          return MovieData.fromJson(snapshot.data()!);
        },
        toFirestore: (movieData, options) => movieData.toJson());

Future<void> addTaskToDatabase(MovieData movieData) {
  var tasksCollection = getFavouriteMoviesCollection();
  return tasksCollection.add(movieData);
}
