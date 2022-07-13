import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

class GetTopTv {
  final TvRepository repository;

  GetTopTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTopTv();
  }
}