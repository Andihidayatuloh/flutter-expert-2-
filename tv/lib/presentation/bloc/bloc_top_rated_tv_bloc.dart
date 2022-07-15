import 'package:tv/tv.dart';

abstract class BlocTopRatedTvEvent extends Equatable {
  const BlocTopRatedTvEvent();

  @override
  List<Object> get props => [];
}

class BlocGetTopRatedTvEvent extends BlocTopRatedTvEvent {}

abstract class BlocTopRatedTvState extends Equatable {
  const BlocTopRatedTvState();

  @override
  List<Object> get props => [];
}

class BlocTopRatedTvEmpty extends BlocTopRatedTvState {}

class BlocTopRatedTvLoading extends BlocTopRatedTvState {}

class BlocTopRatedTvError extends BlocTopRatedTvState {
  final String message;

  const BlocTopRatedTvError(this.message);

  @override
  List<Object> get props => [message];
}

class BlocTopRatedTvLoaded extends BlocTopRatedTvState {
  final List<Tv> result;

  const BlocTopRatedTvLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class TopRatedTvBloc extends Bloc<BlocTopRatedTvEvent, BlocTopRatedTvState> {
  final GetTopTv _getTopRatedTv;

  TopRatedTvBloc(this._getTopRatedTv) : super(BlocTopRatedTvEmpty()) {
    on<BlocTopRatedTvEvent>((event, emit) async {
      emit(BlocTopRatedTvLoading());
      final result = await _getTopRatedTv.execute();

      result.fold(
        (failure) {
          emit(BlocTopRatedTvError(failure.message));
        },
        (data) {
          emit(BlocTopRatedTvLoaded(data));
        },
      );
    });
  }
}
