import 'package:flutter/material.dart';
import 'package:movies/models/search_response.dart';
import 'package:movies/network/remote/api_manager.dart';

import '../mytheme/theme.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var textEditingcontroller = TextEditingController();
  List<SearchResponse> movies = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 10,
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          color: Colors.transparent,
          height: 50.0,
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: TextField(
                  onChanged: (value) {
                    var text = textEditingcontroller.text;
                    text = value;
                  },
                  controller: textEditingcontroller,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xff363535),
                      contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                      ),
                      hintText: 'Search',
                      hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey)),
                ),
              ),
            ],
          ),
        ),
        FutureBuilder(
          future: ApiManager.search(textEditingcontroller.text),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data == null) {
              return Column(
                children: [
                  Image(image: AssetImage('assets/images/nomoviefound.png')),
                  Text("no movie found")
                ],
              );
            }

            return Expanded(
              child: ListView.builder(
                  itemCount: snapshot.data?.totalResults,
                  itemBuilder: (context, index) => movieConatiner(
                      "", "${snapshot.data?.results?[index].title}", "", "")),
            );
          },
        ),
      ],
    );
  }
}

Widget movieConatiner(
        String imagepath, String moviename, String date, String author) =>
    Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Image(
                image: AssetImage(imagepath), //api
                width: 100,
                height: 100,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              children: [
                Text(moviename),
                Text(date),
                Text(author),
              ],
            ),
          ],
        ),
        const Divider(
          height: 10,
          color: Colors.white,
          endIndent: 25,
          indent: 25,
        ),
      ],
    );
