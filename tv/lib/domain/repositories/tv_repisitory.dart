import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv/tv.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getNowPlayingTv();
  Future<Either<Failure, List<Tv>>> getPopularTv();
  Future<Either<Failure, List<Tv>>> getTopTv();
  Future<Either<Failure, TvDetail>> getTvDetail(int id);
  Future<Either<Failure, List<Tv>>> getTvRecommendation(int id);
  Future<Either<Failure, List<Tv>>> searchTv(String query);
  Future<Either<Failure, String>> saveWatchlist(TvDetail tv);
  Future<Either<Failure, String>> removeWatchlist(TvDetail tv);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<Tv>>> getWatchlistTv();
}
