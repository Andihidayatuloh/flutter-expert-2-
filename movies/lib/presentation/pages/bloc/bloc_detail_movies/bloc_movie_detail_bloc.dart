import 'package:movies/movies.dart';

class BlocMovieDetailBloc extends Bloc<MovieDetailEvent, BlocMovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  BlocMovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(BlocMovieDetailState.initial()) {
    on<FetchMovieDetail>(
      (event, emit) async {
        final id = event.id;

        emit(state.copyWith(movieState: RequestState.Loading));
        final detailResult = await getMovieDetail.execute(id);
        final recommendationResult = await getMovieRecommendations.execute(id);

        detailResult.fold(
          (failure) async {
            emit(
              state.copyWith(
                movieState: RequestState.Error,
                message: failure.message,
              ),
            );
          },
          (movie) async {
            emit(
              state.copyWith(
                recommendationState: RequestState.Loading,
                movieDetail: movie,
                movieState: RequestState.Loaded,
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
              (movies) {
                emit(
                  state.copyWith(
                    recommendationState: RequestState.Loaded,
                    movieRecommendations: movies,
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
        final movie = event.movieDetail;

        final result = await saveWatchlist.execute(movie);

        result.fold(
          (failure) {
            emit(state.copyWith(watchlistMessage: failure.message));
          },
          (successMessage) async {
            emit(state.copyWith(watchlistMessage: successMessage));
          },
        );

        add(LoadWatchlistStatus(movie.id));
      },
    );

    on<RemoveFromWatchlist>(
      (event, emit) async {
        final movie = event.movieDetail;

        final result = await removeWatchlist.execute(movie);

        result.fold(
          (failure) {
            emit(state.copyWith(watchlistMessage: failure.message));
          },
          (successMessage) async {
            emit(state.copyWith(watchlistMessage: successMessage));
          },
        );

        add(LoadWatchlistStatus(movie.id));
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
