import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies/models/movie_data.dart';
import 'package:movies/network/remote/firebase_utils.dart';
import 'movie_item.dart';

class WatchListScreen extends StatelessWidget {
  const WatchListScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
        ),
        const Text("Watchlist", style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),),
        StreamBuilder<QuerySnapshot<MovieData>>(
          stream: streamWishList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            }
            if (snapshot.data?.size == 0) {
              return const Center(
                child: Text("Watchlist is Empty", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), ),
              );
            }
            List<MovieData>? watchlist =
                snapshot.data?.docs.map((value) => value.data()).toList();
            return Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider(color: Color.fromRGBO(112, 112, 112, 1.0),);
                },
                itemCount: watchlist!.length,
                itemBuilder: (context, index) => MovieItem(watchlist![index]),
              ),
            );
          },
        )
      ],
    );
  }
}
