import 'package:search/search.dart';
import 'package:rxdart/rxdart.dart';

// Bloc Tv Search Event
abstract class BlocTvSearchEvent extends Equatable {}

class OnQueryTvChanged extends BlocTvSearchEvent {
  final String query;
  OnQueryTvChanged(this.query);
  @override
  List<Object> get props => [query];
}

// Bloc Tv Search State
abstract class BlocTvSearchState extends Equatable {}

class BlocTvSearchEmpty extends BlocTvSearchState {
  @override
  List<Object> get props => [];
}

class BlocTvSearchLoading extends BlocTvSearchState {
  @override
  List<Object> get props => [];
}

class BlocTvSearchError extends BlocTvSearchState {
  final String message;
  BlocTvSearchError(this.message);
  @override
  List<Object> get props => [message];
}

class BlocTvSearchLoaded extends BlocTvSearchState {
  final List<Tv> data;
  BlocTvSearchLoaded(this.data);
  @override
  List<Object> get props => [data];
}

// Bloc Tv Search
class BlocTvSearchBloc extends Bloc<BlocTvSearchEvent, BlocTvSearchState> {
  final SearchTv search;

  BlocTvSearchBloc({required this.search}) : super(BlocTvSearchEmpty()) {
    on<OnQueryTvChanged>((event, emit) async {
      final query = event.query;
      emit(BlocTvSearchLoading());

      final result = await search.execute(query);
      result.fold(
        (failure) => emit(BlocTvSearchError(failure.message)),
        (data) => emit(BlocTvSearchLoaded(data)),
      );
    }, transformer: debounceTv(const Duration(milliseconds: 500)));
  }

  EventTransformer<OnQueryTvChanged> debounceTv<OnQueryTvChanged>(
      Duration duration) {
    return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
  }
}
