class MovieData{
  String title;
  String date;
  List<String> authors;
  String imagePath;

  MovieData({required this.title, required this.date, required this.authors, required this.imagePath});

  Map<String, dynamic> toJson(){
    return {
      "title": title,
      "data": date,
      "authors": authors,
      "imagePath": imagePath,
    };
  }
  MovieData.fromJson(Map<String, dynamic> json):this(
  title: json["title"],
    date: json["date"],
    authors: json["authors"],
    imagePath: json["imagePath"],
  );
}