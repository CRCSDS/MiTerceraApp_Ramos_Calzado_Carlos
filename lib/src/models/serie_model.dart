class Series {

  List<Serie> items = new List();

  Series();

  Series.fromJsonList( List<dynamic> jsonList  ) {

    if ( jsonList == null ) return;

    for ( var item in jsonList  ) {
      final serie = new Serie.fromJsonMap(item);
      items.add( serie );
    }

  }

}



class Serie {

  String uniqueId;

  int voteCount;
  int id;
  bool video;
  double voteAverage;
  String title;
  double popularity;
  String posterPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String releaseDate;
  String firstAirdate;
  String name;
  String originalName;

  Serie({
    this.voteCount,
    this.id,
    this.video,
    this.voteAverage,
    this.title,
    this.popularity,
    this.posterPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.releaseDate,
    this.firstAirdate,
    this.name,
    this.originalName,
  });

  Serie.fromJsonMap( Map<String, dynamic> json ) {

    voteCount        = json['vote_count'];
    id               = json['id'];
    /* video            = json['video']; */
    voteAverage      = json['vote_average'] / 1;
    /* title            = json['title']; */
    popularity       = json['popularity'] / 1;
    posterPath       = json['poster_path'];
    originalLanguage = json['original_language'];
    /* originalTitle    = json['original_title']; */
    genreIds         = json['genre_ids'].cast<int>();
    backdropPath     = json['backdrop_path'];
    /* adult            = json['adult']; */
    overview         = json['overview'];
    /* releaseDate      = json['release_date']; */
    firstAirdate     = json['first_air_date'];
    name             = json['name'];
    originalName     = json['original_name'];

  }

  getPosterImg() {

    if ( posterPath == null ) {
      return 'https://cdn11.bigcommerce.com/s-auu4kfi2d9/stencil/59512910-bb6d-0136-46ec-71c445b85d45/e/933395a0-cb1b-0135-a812-525400970412/icons/icon-no-image.svg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }

  }

  getBackgroundImg() {

    if ( posterPath == null ) {
      return 'https://cdn11.bigcommerce.com/s-auu4kfi2d9/stencil/59512910-bb6d-0136-46ec-71c445b85d45/e/933395a0-cb1b-0135-a812-525400970412/icons/icon-no-image.svg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }

  }



}


