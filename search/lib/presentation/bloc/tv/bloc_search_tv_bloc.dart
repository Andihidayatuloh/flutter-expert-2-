import 'package:search/search.dart';

class BlocSearchTvBloc extends Bloc<BlocSearchEvent, BlocSearchState> {
  final SearchTv _searchMovies;

  BlocSearchTvBloc(this._searchMovies) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final quaery = event.quaery;

      emit(SearchLoading());
      final result = await _searchMovies.execute(quaery);

      result.fold(
        (failure) {
          emit(SearchError(failure.message));
        },
        (data) {
          emit(SearchLoaded<Tv>(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
