import 'package:search/presentation/bloc/bloc_search_event.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/presentation/bloc/bloc_search_state.dart';
import 'package:search/search.dart';

// part '../bloc/bloc/bloc_search_event.dart';

// part 'bloc/bloc_search_state.dart';

class BlocSearchMoviesBloc extends Bloc<BlocSearchEvent, BlocSearchState> {
  final SearchMovies _searchMovies;

  BlocSearchMoviesBloc(this._searchMovies) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.quaery;

      emit(SearchLoading());
      final result = await _searchMovies.execute(query);

      result.fold(
        (failure) {
          emit(SearchError(failure.message));
        },
        (data) {
          emit(SearchLoaded<Movie>(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}