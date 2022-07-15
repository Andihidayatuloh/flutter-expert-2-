import 'package:tv/tv.dart';

abstract class BlocPopularTvEvent extends Equatable {
  const BlocPopularTvEvent();

  @override
  List<Object> get props => [];
}

class BlocGetPopularTvEvent extends BlocPopularTvEvent {}

abstract class BlocPopularTvState extends Equatable {
  const BlocPopularTvState();

  @override
  List<Object> get props => [];
}

class BlocPopularTvEmpty extends BlocPopularTvState {}

class BlocPopularTvLoading extends BlocPopularTvState {}

class BlocPopularTvError extends BlocPopularTvState {
  final String message;

  const BlocPopularTvError(this.message);

  @override
  List<Object> get props => [message];
}

class BlocPopularTvLoaded extends BlocPopularTvState {
  final List<Tv> result;

  const BlocPopularTvLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class BlocPopularTvBloc extends Bloc<BlocPopularTvEvent, BlocPopularTvState> {
  final GetPopularTv _getPopularTv;

  BlocPopularTvBloc(this._getPopularTv) : super(BlocPopularTvEmpty()) {
    on<BlocPopularTvEvent>((event, emit) async {
      emit(BlocPopularTvLoading());
      final result = await _getPopularTv.execute();

      result.fold(
        (failure) {
          emit(BlocPopularTvError(failure.message));
        },
        (data) {
          emit(BlocPopularTvLoaded(data));
        },
      );
    });
  }
}
