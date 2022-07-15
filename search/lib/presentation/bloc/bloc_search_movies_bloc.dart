import 'package:search/search.dart';
import 'package:rxdart/rxdart.dart';

// Bloc Movies Search Event
abstract class BlocMoviesSearchEvent extends Equatable {}

class OnQueryMoviesChanged extends BlocMoviesSearchEvent {
  final String query;
  OnQueryMoviesChanged(this.query);
  @override
  List<Object> get props => [query];
}

// Bloc Movies Search State
abstract class BlocMoviesSearchState extends Equatable {}

class BlocMoviesSearchEmpty extends BlocMoviesSearchState {
  @override
  List<Object> get props => [];
}

class BlocMoviesSearchLoading extends BlocMoviesSearchState {
  @override
  List<Object> get props => [];
}

class BlocMoviesSearchError extends BlocMoviesSearchState {
  final String message;
  BlocMoviesSearchError(this.message);
  @override
  List<Object> get props => [message];
}

class BlocMoviesSearchLoaded extends BlocMoviesSearchState {
  final List<Movie> data;
  BlocMoviesSearchLoaded(this.data);
  @override
  List<Object> get props => [data];
}

// Bloc Movies Search
class BlocMoviesSearchBloc
    extends Bloc<BlocMoviesSearchEvent, BlocMoviesSearchState> {
  final SearchMovies search;

  BlocMoviesSearchBloc({required this.search})
      : super(BlocMoviesSearchEmpty()) {
    on<OnQueryMoviesChanged>((event, emit) async {
      final query = event.query;
      emit(BlocMoviesSearchLoading());

      final result = await search.execute(query);
      result.fold(
        (failure) => emit(BlocMoviesSearchError(failure.message)),
        (data) => emit(BlocMoviesSearchLoaded(data)),
      );
    }, transformer: debounceMovies(const Duration(milliseconds: 500)));
  }

  EventTransformer<OnQueryMoviesChanged> debounceMovies<OnQueryMoviesChanged>(
      Duration duration) {
    return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
  }
}
