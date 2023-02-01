class CategoryData {
  int id;
  String category;
  String image;

  CategoryData(this.id, this.category, this.image);

  static List<CategoryData> getCategories() {
    return [
      CategoryData(28,
          "Action", "assets/images/sports.png",
          ),
      CategoryData(12,
          "Adventure", "assets/images/bussines.png",
          ),
      CategoryData(16,
          "Animation", "assets/images/politics.png",
          ),
      CategoryData(35,
          "comedy", "assets/images/environment.png",
          ),
      CategoryData(80,
          "Crime", "assets/images/health.png",
          ),
      CategoryData(99,
          "Documentary", "assets/images/science.png",
          ),
      CategoryData(18,
          "Drama", "assets/images/science.png",
          ),
      CategoryData(10751,
          "Family", "assets/images/science.png",
          ),
      CategoryData(14,
        "Fantasy", "assets/images/science.png",
      ),
      CategoryData(27,
        "Horror", "assets/images/science.png",
      ),
      CategoryData(10402,
        "Music", "assets/images/science.png",
      ),
      CategoryData(9648,
        "Mystery", "assets/images/science.png",
      ),CategoryData(10749,
        "Romance", "assets/images/science.png",
      ),CategoryData(878,
        "Science Fiction", "assets/images/science.png",
      ),CategoryData(10770,
        "TV Movie", "assets/images/science.png",
      ),CategoryData(53,
        "Thriller", "assets/images/science.png",
      ),CategoryData(10752,
        "War", "assets/images/science.png",
      ),CategoryData(37,
        "Western", "assets/images/science.png",)
    ];
  }
}
