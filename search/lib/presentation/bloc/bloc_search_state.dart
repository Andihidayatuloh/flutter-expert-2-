import 'package:equatable/equatable.dart';

abstract class BlocSearchState extends Equatable {
  const BlocSearchState();

  @override
  List<Object> get props => [];
}

class SearchEmpty extends BlocSearchState {}
class SearchLoading extends BlocSearchState {}
class SearchError extends BlocSearchState {
  final String message;
  
  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchLoaded<T> extends BlocSearchState {
  final List<T> result;

  const SearchLoaded(this.result);

  @override
  List<Object> get props => [result];
}