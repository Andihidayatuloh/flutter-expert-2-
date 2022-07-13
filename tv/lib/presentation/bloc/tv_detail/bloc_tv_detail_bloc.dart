import 'package:tv/tv.dart';



class BlocTvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendation;
  final GetWatchListStatusTv getWatchListStatus;
  final SaveWatchlistTv saveWatchlist;
  final RemoveWatchlistTv removeWatchlist;

  BlocTvDetailBloc({
    required this.getTvDetail,
    required this.getTvRecommendation,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(TvDetailState.initial()) {
    on<FetchTvDetail>(
      (event, emit) async {
        final id = event.id;

        emit(state.copyWith(tvState: RequestState.Loading));
        final detailResult = await getTvDetail.execute(id);
        final recommendationResult = await getTvRecommendation.execute(id);

        detailResult.fold(
          (failure) async {
            emit(
              state.copyWith(
                tvState: RequestState.Error,
                message: failure.message,
              ),
            );
          },
          (tv) async {
            emit(
              state.copyWith(
                recommendationState: RequestState.Loading,
                tvDetail: tv,
                tvState: RequestState.Loaded,
                message: '',
              ),
            );
            recommendationResult.fold(
              (failure) {
                emit(
                  state.copyWith(
                    recommendationState: RequestState.Error,
                    message: failure.message,
                  ),
                );
              },
              (tvs) {
                emit(
                  state.copyWith(
                    recommendationState: RequestState.Loaded,
                    tvRecommendations: tvs,
                    message: '',
                  ),
                );
              },
            );
          },
        );
      },
    );

    on<AddWatchlist>(
      (event, emit) async {
        final tv = event.tvDetail;

        final result = await saveWatchlist.execute(tv);

        result.fold(
          (failure) {
            emit(state.copyWith(watchlistMessage: failure.message));
          },
          (successMessage) async {
            emit(state.copyWith(watchlistMessage: successMessage));
          },
        );

        add(LoadWatchlistStatus(tv.id));
      },
    );

    on<RemoveFromWatchlist>(
      (event, emit) async {
        final tv = event.tvDetail;

        final result = await removeWatchlist.execute(tv);

        result.fold(
          (failure) {
            emit(state.copyWith(watchlistMessage: failure.message));
          },
          (successMessage) async {
            emit(state.copyWith(watchlistMessage: successMessage));
          },
        );

        add(LoadWatchlistStatus(tv.id));
      },
    );

    on<LoadWatchlistStatus>(
      (event, emit) async {
        final id = event.id;

        final result = await getWatchListStatus.execute(id);
        emit(state.copyWith(isAddedToWatchlist: result));
      },
    );
  }
}
