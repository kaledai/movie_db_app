class MovieResultModel {
  MovieResultModel({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  DateTime? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  factory MovieResultModel.fromJson(Map<String, dynamic> json) =>
      MovieResultModel(
        adult: json["adult"] as bool?,
        backdropPath: json["backdrop_path"] as String?,
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"] as int?,
        originalLanguage: json["original_language"] as String?,
        originalTitle: json["original_title"] as String?,
        overview: json["overview"] as String?,
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"] as String?,
        releaseDate: DateTime.parse(json["release_date"]),
        title: json["title"] as String?,
        video: json["video"] as bool?,
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"] as int?,
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds!.map((x) => x)),
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date":
            "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}