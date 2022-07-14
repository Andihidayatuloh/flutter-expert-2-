import 'package:core/core.dart';


final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

// Data Tv Series
final testTv = Tv(
    posterPath: "/yvrNJSy5moG8W7WoxJJXw1Sr5Vl.jpg.jpg",
    popularity: 18.465,
    id: 65733,
    backdropPath: "/cYA3OLPiGJYSTfeFbTl9JbSqZKA.jpg",
    voteAverage: 7.7,
    overview:
        "Robotic cat Doraemon is sent back in time from the 22nd century to protect 10-year-old Noby, a lazy and uncoordinated boy who is destined to have a tragic future. Doraemon can create secret gadgets from a pocket on his stomach, but they usually cause more bad than good because of Noby's propensity to misuse them.",
    originCountry: ["JP"],
    genreIds: [10759,16,35,10765],
    originalLanguage: "ja",
    voteCount: 37,
    name: "Doraemon",
    originalName: "ドラえもん");

final testTvList = [testTv];

const testTvDetail = TvDetail(
  episodeRunTime: [1],
  genres: [Genre(id: 1, name: 'name')],
  id: 1,
  name: 'name',
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  seasons: [
    Season(
      episodeCount: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      seasonNumber: 1,
    )
  ],
  voteAverage: 1,
);

final testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'name': 'name',
  'posterPath': 'posterPath',
  'overview': 'overview',
};

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

