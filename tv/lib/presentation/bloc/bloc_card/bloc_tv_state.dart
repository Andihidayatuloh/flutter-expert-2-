import 'package:tv/tv.dart';

abstract class BlocTvState extends Equatable {
  const BlocTvState();
  
  @override
  List<Object> get props => [];
}

class TvEmpty extends BlocTvState {}

class TvLoading extends BlocTvState {}

class TvError extends BlocTvState {
  final String message;

  const TvError(this.message);

  @override
  List<Object> get props => [message];
}

class TvLoaded extends BlocTvState {
  final List<Tv> result;

  const TvLoaded(this.result);

  @override
  List<Object> get props => [result];
}
