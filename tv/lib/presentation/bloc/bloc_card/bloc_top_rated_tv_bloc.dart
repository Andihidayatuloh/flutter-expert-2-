import 'package:tv/tv.dart';

class BlocTopTvBloc extends Bloc<BlocTvEvent, BlocTvState> {
  final GetTopTv _getTopTv;

  BlocTopTvBloc(this._getTopTv) : super(TvEmpty()) {
    on<BlocGetTvEvent>((event, emit) async {
      emit(TvLoading());
      final result = await _getTopTv.execute();

      result.fold((Failure) {
        emit(TvError(Failure.message));
      }, (data) {
        emit(TvLoaded(data));
      });
    });
  }
}
