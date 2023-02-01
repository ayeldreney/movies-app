import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies/models/movie_data.dart';

CollectionReference<MovieData> getFavouriteMoviesCollection() =>
    FirebaseFirestore.instance.collection("movies").withConverter<MovieData>(
        fromFirestore: (snapshot, options) {
          return MovieData.fromJson(snapshot.data()!);
        },
        toFirestore: (movieData, options) => movieData.toJson());

Future<void> addFavouriteMovieToDatabase(MovieData movieData) {
  var moviesCollection = getFavouriteMoviesCollection();
  return moviesCollection.doc(movieData.title).set(movieData);
}

Stream<QuerySnapshot<MovieData>> streamWishList(){
  return getFavouriteMoviesCollection().snapshots();
}

Future<void> deleteMovieFromFirebase(String? movieTitle){
  return getFavouriteMoviesCollection().doc(movieTitle).delete();
}
Future<bool> isInDatabase (String? movieTitle) async {
  QuerySnapshot<MovieData> snapshots = await getFavouriteMoviesCollection().where("title", isEqualTo: movieTitle).get();
  return snapshots.size == 0? false : true;
}

