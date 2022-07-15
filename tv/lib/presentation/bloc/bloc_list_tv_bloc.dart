import 'package:tv/tv.dart';

abstract class BlocTvEvent extends Equatable {
  const BlocTvEvent();

  @override
  List<Object> get props => [];
}

class BlocGetTvEvent extends BlocTvEvent {}

abstract class BlocTvState extends Equatable {
  const BlocTvState();

  @override
  List<Object> get props => [];
}

class BlocTvEmpty extends BlocTvState {}

class BlocTvLoading extends BlocTvState {}

class BlocTvError extends BlocTvState {
  final String message;

  const BlocTvError(this.message);

  @override
  List<Object> get props => [message];
}

class BlocTvLoaded extends BlocTvState {
  final List<Tv> result;

  const BlocTvLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class BlocTvListBloc extends Bloc<BlocTvEvent, BlocTvState> {
  final GetNowPlayingTv _getNowPlayingTv;

  BlocTvListBloc(this._getNowPlayingTv) : super(BlocTvEmpty()) {
    on<BlocGetTvEvent>((event, emit) async {
      emit(BlocTvLoading());
      final result = await _getNowPlayingTv.execute();

      result.fold(
        (failure) {
          emit(BlocTvError(failure.message));
        },
        (data) {
          emit(BlocTvLoaded(data));
        },
      );
    });
  }
}
