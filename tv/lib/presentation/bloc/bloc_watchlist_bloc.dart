import 'package:tv/tv.dart';

class WatchlistTvBloc extends Bloc<BlocWatchlistTvEvent, WatchlistState> {
  final GetWatchlistTv _getWatchlistTvs;

  WatchlistTvBloc(this._getWatchlistTvs) : super(WatchlistEmpty()) {
    on<BlocWatchlistTvEvent>((event, emit) async {
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

abstract class BlocWatchlistTvEvent extends Equatable {
  const BlocWatchlistTvEvent();

  @override
  List<Object> get props => [];
}

class BlocGetWatchlistTv extends BlocWatchlistTvEvent {}

abstract class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object> get props => [];
}

class WatchlistEmpty extends WatchlistState {}

class WatchlistLoading extends WatchlistState {}

class WatchlistError extends WatchlistState {
  final String message;

  const WatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistLoaded<T> extends WatchlistState {
  final List<T> result;

  const WatchlistLoaded(this.result);

  @override
  List<Object> get props => [result];
}
