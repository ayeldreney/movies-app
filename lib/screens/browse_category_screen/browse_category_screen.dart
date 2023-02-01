import 'package:flutter/material.dart';
import 'package:movies/models/category_data.dart';
import 'package:movies/network/remote/api_manager.dart';
import 'package:movies/screens/browse_category_screen/categoryCard.dart';


class BrowseCategoryScreen extends StatefulWidget {
  const BrowseCategoryScreen({super.key});

  @override
  State<BrowseCategoryScreen> createState() => _BrowseCategoryScreenState();
}

class _BrowseCategoryScreenState extends State<BrowseCategoryScreen> {
  @override
  Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
          ),
          const Text("Browse Category", style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),),
          FutureBuilder(
            future: ApiManager.getGenres(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              }
              if (snapshot.data?.genres?.length == 0) {
                return const Center(
                  child: Text("Genres is Empty", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), ),
                );
              }
              List<Genres>? watchlist =
              snapshot.data?.genres;
              return Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,

                  ),
                  itemCount: watchlist!.length,
                  itemBuilder: (context, index) => CategoryCard(genre: watchlist[index]),
                ),
              );
            },
          )
        ],
      );
  }
}
