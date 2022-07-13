import 'package:tv/tv.dart';


class WatchlistTvBloc extends Bloc<BlocWatchlistEvent, WatchlistState> {
  final GetWatchlistTv _getWatchlistTvs;

  WatchlistTvBloc(this._getWatchlistTvs) : super(WatchlistEmpty()) {
    on<BlocWatchlistEvent>((event, emit) async {
      emit(WatchlistLoading());
      final result = await _getWatchlistTvs.execute();

      result.fold(
        (failure) {
          emit(WatchlistError(failure.message));
        },
        (data) {
          emit(WatchlistLoaded<Tv>(data));
        },
      );
    });
  }
}