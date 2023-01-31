import 'package:flutter/material.dart';
import 'package:movies/modules/movies screens/Release_Latest/release_container.dart';
import 'package:movies/network/remote/api_manager.dart';
import 'package:movies/models/upcomming_responce.dart';
import 'package:movies/mytheme/theme.dart';

class Release_Latest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourceUpcoming>(
      future: ApiManager.getLatest(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: MyTheme.orange,
          ));
        } else if (snapshot.hasError) {
          return Column(
            children: [
              Text('Something went wrong'),
              ElevatedButton(onPressed: () {}, child: Text('Trey again'))
            ],
          );
        }
        if (snapshot.data?.page != 1) {
// server has code and message
          return Column(
            children: [
              Text(snapshot.data?.StatusMessage ?? ''),
              ElevatedButton(onPressed: () {}, child: Text('Try again'))
            ],
          );
        }
//data
        var resultList = snapshot.data?.results ?? [];
        return Container(
            margin: EdgeInsets.only(left: 13, bottom: 5),
            padding: EdgeInsets.all(10),
            color: MyTheme.gray,
            width: double.infinity,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'New Releases',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 17),
              ),
              SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Releases_Container(
                        imagePath: resultList[index].posterPath ?? '');
                  },
                  itemCount: resultList.length,
                ),
              )
            ]));
      },
    );
  }
}
