import 'package:flutter/material.dart';
import 'package:movies/network/remote/api_manager.dart';
import 'package:movies/screens/search_screen/movie_item.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          color: Colors.transparent,
          height: 50.0,
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Form(
                  child: TextFormField(
                    controller: searchController,
                    onChanged: (text){
                      setState(() {

                      });
                    },
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xff363535),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 0.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                        ),
                        hintText: 'Search',
                        hintStyle: const TextStyle(
                            fontSize: 15.0, color: Colors.grey)),
                  ),
                ),
              ),
            ],
          ),
        ),
        FutureBuilder(
          future: ApiManager.search(searchController.text),
          builder: (context, snapshot) {
            print(searchController.text);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            }
            if(searchController.text == ""){
              return const Center(
                child: Text("Write Something to Search for"),
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
                itemBuilder: (context, index) => MovieItem(resultMovie: items![index],),
              ),
            );
          },
        )
      ],
    );
  }
}
