import 'package:flutter/material.dart';

import 'package:movies/mytheme/theme.dart';

class Search extends StatelessWidget {
  var textEditingcontroller = TextEditingController();
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
                child: Form(
                  child: TextFormField(
                    controller: textEditingcontroller,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.left,
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
                        hintStyle:
                            TextStyle(fontSize: 15.0, color: Colors.grey)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget movieConatiner() => Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Image(
                image: AssetImage('assets/images/browse.png'), //api
                width: 100,
                height: 100,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              children: [
                Text("dsajdnaknda"), //api
                Text("dsajdnaknda"), //api
                Text("dsajdnaknda"), //api
              ],
            ),
          ],
        ),
        Divider(
          height: 10,
          color: Colors.white,
          endIndent: 25,
          indent: 25,
        ),
      ],
    );
