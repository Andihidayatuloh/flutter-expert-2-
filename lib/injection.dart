import 'dart:io';

import 'main_library.dart';
import 'package:http/io_client.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init(HttpClient client) {
  // bloc movie
  locator.registerFactory(
    () => BlocMoviesSearchBloc(
      search: locator(),
    ),
  );
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
    ),
  );
  locator.registerFactory(
    () => BlocMovieWatchlistStatus(
      getWatchListStatus: locator(),
    ),
  );
  locator.registerFactory(
    () => BlocWatchlistMovieAR(
      saveWatchlist: locator(),
      removeWatchlist: locator(),
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

  // bloc tv
  locator.registerFactory(
    () => BlocTvListBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => BlocTvDetailBloc(
      getTvDetail: locator(),
      getTvRecommendations: locator(),
    ),
  );
  locator.registerFactory(
    () => BlocTvWatchlistStatus(
      getWatchListStatus: locator(),
    ),
  );
  locator.registerFactory(
    () => BlocWatchlistTvAR(
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => BlocTvSearchBloc(
      search: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvBloc(
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
  locator.registerLazySingleton(() => IOClient(client));
}
