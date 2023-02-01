class MovieData{
  String? title;
  String? releaseDate;
  String? posterPath;
  bool? wishlisted;

  

  MovieData({required this.title, required this.releaseDate, required this.posterPath, wishlisted = false});

  Map<String, dynamic> toJson(){
    return {
      "title": title,
      "releaseDate": releaseDate,
      "posterPath": posterPath,
    };
  }
  MovieData.fromJson(Map<String, dynamic> json):this(
  title: json["title"],
    releaseDate: json["releaseDate"],
    posterPath: json["posterPath"],
  );
}