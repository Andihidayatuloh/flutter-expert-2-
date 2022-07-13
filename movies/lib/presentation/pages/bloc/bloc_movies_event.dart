import 'package:movies/movies.dart';

abstract class BlocMoviesEvent extends Equatable {
  const BlocMoviesEvent();

  @override
  List<Object> get props => [];
}
 class BlocGetMoviesEvent extends BlocMoviesEvent{}