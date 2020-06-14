class Movies {
  List<Movie> movies = new List();

  Movies();

  Movies.fromJsonList(List<dynamic> moviesJson) {
    if ( moviesJson == null ) return;

    for ( var movieJson in moviesJson ) {
      final movie = new Movie.fromJsonMap(movieJson);
      movies.add(movie);
    }
  }
}

class Movie {
  String uniqueId;

  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Movie({
    this.uniqueId,
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  Movie.fromJsonMap( Map<String, dynamic> json ) {
    popularity = json['popularity'] / 1;
    voteCount = json['vote_count'];
    video = json['video'];
    posterPath = json['poster_path'];
    id = json['id'];
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>();
    title = json['title'];
    voteAverage = json['vote_average'] / 1;
    overview = json['overview'];
    releaseDate = json['release_date'];
  }

  getPosterImg() {

    if ( posterPath  == null ) {
      return 'https://thumbs.dreamstime.com/b/ning%C3%BAn-icono-disponible-de-la-imagen-plano-ejemplo-del-vector-132482930.jpg';
    }
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }

  getBackgroundImg() {

    if ( backdropPath  == null ) {
      return 'https://thumbs.dreamstime.com/b/ning%C3%BAn-icono-disponible-de-la-imagen-plano-ejemplo-del-vector-132482930.jpg';
    }
    return 'https://image.tmdb.org/t/p/w500$backdropPath';
  }
}

