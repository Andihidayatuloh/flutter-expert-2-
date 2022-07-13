import 'package:movies/movies.dart';


abstract class BlocMoviesState extends Equatable {
  const BlocMoviesState();
  
  @override
  List<Object> get props => [];
}
class BlocMoviesEmpty extends BlocMoviesState {}

class BlocMoviesLoading extends BlocMoviesState {}

class BlocMoviesError extends BlocMoviesState {
  final String message;

  const BlocMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class BlocMoviesLoaded extends BlocMoviesState {
  final List<Movie> result;

  const BlocMoviesLoaded(this.result);

  @override
  List<Object> get props => [result];
}
