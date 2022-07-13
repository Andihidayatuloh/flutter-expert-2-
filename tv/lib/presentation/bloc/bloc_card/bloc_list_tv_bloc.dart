import 'package:tv/tv.dart';

class BlocListTvBloc extends Bloc<BlocTvEvent, BlocTvState> {
  final GetPopularTv _getPopularTv;

  BlocListTvBloc(this._getPopularTv) : super(TvEmpty()) {
    on<BlocGetTvEvent>((event, emit) async {
      emit(TvLoading());
      final result = await _getPopularTv.execute();

      result.fold((Failure) {
        emit(TvError(Failure.message));
      }, (data) {
        emit(TvLoaded(data));
      });
    });
  }
}
