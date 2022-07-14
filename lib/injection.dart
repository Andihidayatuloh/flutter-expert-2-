import 'main_library.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:search/search.dart';

final locator = GetIt.instance;

void init() {
  // provider movie
  locator.registerFactory(
    () => BlocMoviesListBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => BlocPopularMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => BlocMovieDetailBloc(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
 locator.registerFactory(
    () => BlocSearchMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesBloc(
      locator(),
    ),
  );

  // provider tv
  locator.registerFactory(
    () => BlocListTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => BlocTvDetailBloc(
      getTvDetail: locator(),
      getTvRecommendation: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => BlocSearchTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => BlocTopTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => BlocPopularTvBloc(
      locator(),
    ),
  );

  // use case movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // use case tv
  locator.registerLazySingleton(() => GetNowPlayingTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTv(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));

  // repository movie
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // repository tv
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources movie
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // data sources tv
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvDataSource>(
      () => TvLocalDataSourceImpl(tvDatabaseHelperTv: locator()));

  // helper movie
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // helper tv
  locator.registerLazySingleton<DatabaseTv>(() => DatabaseTv());

  // external
  locator.registerLazySingleton(() => http.Client());
}
