import 'package:movies/movies.dart';

// Detail Bloc
class BlocMovieDetailBloc
    extends Bloc<BlocMovieDetailEvent, BlocMovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;

  BlocMovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
  }) : super((BlocMoviesDetailEmpty())) {
    on<FetchMovieDetail>((event, emit) async {
      final id = event.id;
      emit(BlocMoviesDetailLoading());

      final detail = await getMovieDetail.execute(id);
      final recommendation = await getMovieRecommendations.execute(id);

      detail.fold((failure) => emit(BlocMoviesDetailError(failure.message)),
          (dataDetail) {
        emit(BlocMoviesDetailLoading());

        recommendation.fold(
            (failure) => emit(BlocMoviesDetailError(failure.message)),
            (dataRecommendations) =>
                emit(BlocMoviesDetailLoaded(dataDetail, dataRecommendations)));
      });
    });
  }
}

// Bloc Watchlist Status
class BlocMovieWatchlistStatus
    extends Bloc<BlocWatchlistStatusEvent, BlocWatchlistStatusState> {
  final GetWatchListStatus getWatchListStatus;

  BlocMovieWatchlistStatus({required this.getWatchListStatus})
      : super((BlocWatchlistStatusEmpty())) {
    on<LoadWatchlistMoviesStatus>(
      (event, emit) async {
        emit(BlocWatchlistStatusLoading());
        final id = event.id;

        final result = await getWatchListStatus.execute(id);
        emit(WatchlistMoviesStatus(result));
      },
    );
  }
}

// Bloc Add & Remove Watchlist
class BlocWatchlistMovieAR
    extends Bloc<BlocWatchlistAREvent, BlocWatchlistARState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  BlocWatchlistMovieAR({
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super((BlocWatchlistEmpty())) {
    on<AddWatchlistMovies>(
      (event, emit) async {
        emit(BlocWatchlistLoading());
        final movie = event.movieDetail;
        final result = await saveWatchlist.execute(movie);

        result.fold(
          (failure) => emit(BlocWatchlistError(failure.message)),
          (data) => emit(WatchlistAddMessage(data)),
        );
      },
    );

    on<RemoveFromWatchlistMovies>(
      (event, emit) async {
        emit(BlocWatchlistLoading());
        final movie = event.movieDetail;
        final result = await removeWatchlist.execute(movie);

        result.fold(
          (failure) => emit(BlocWatchlistError(failure.message)),
          (data) => emit(WatchlistRemoveMessage(data)),
        );
      },
    );
  }
}

// Bloc Movie Detail Event
abstract class BlocMovieDetailEvent extends Equatable {
  const BlocMovieDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieDetail extends BlocMovieDetailEvent {
  final int id;

  const FetchMovieDetail(this.id);

  @override
  List<Object> get props => [id];
}

// Bloc Movie Detail State
abstract class BlocMovieDetailState extends Equatable {
  const BlocMovieDetailState();

  @override
  List<Object> get props => [];
}

class BlocMoviesDetailEmpty extends BlocMovieDetailState {}

class BlocMoviesDetailLoading extends BlocMovieDetailState {}

class BlocMoviesDetailError extends BlocMovieDetailState {
  final String message;

  const BlocMoviesDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class BlocMoviesDetailLoaded extends BlocMovieDetailState {
  final MovieDetail movies;
  final List<Movie> result;

  const BlocMoviesDetailLoaded(this.movies, this.result);

  @override
  List<Object> get props => [result, movies];
}

// Bloc Watchlist Status Event
abstract class BlocWatchlistStatusEvent extends Equatable {
  const BlocWatchlistStatusEvent();

  @override
  List<Object> get props => [];
}

class LoadWatchlistMoviesStatus extends BlocWatchlistStatusEvent {
  final int id;

  const LoadWatchlistMoviesStatus(this.id);

  @override
  List<Object> get props => [id];
}

// Blocw Watchlist Status State
abstract class BlocWatchlistStatusState extends Equatable {
  const BlocWatchlistStatusState();

  @override
  List<Object> get props => [];
}

class BlocWatchlistStatusLoading extends BlocWatchlistStatusState {}

class BlocWatchlistStatusEmpty extends BlocWatchlistStatusState {}

class WatchlistMoviesStatus extends BlocWatchlistStatusState {
  final bool isAddedToWatchlist;

  const WatchlistMoviesStatus(this.isAddedToWatchlist);

  @override
  List<Object> get props => [isAddedToWatchlist];
}

// Bloc Watchlist Add & Remove Event
abstract class BlocWatchlistAREvent extends Equatable {
  const BlocWatchlistAREvent();

  @override
  List<Object> get props => [];
}

class AddWatchlistMovies extends BlocWatchlistAREvent {
  final MovieDetail movieDetail;

  const AddWatchlistMovies(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class RemoveFromWatchlistMovies extends BlocWatchlistAREvent {
  final MovieDetail movieDetail;

  const RemoveFromWatchlistMovies(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

// Bloc Watchlist Add & Remove State
abstract class BlocWatchlistARState extends Equatable {
  const BlocWatchlistARState();

  @override
  List<Object> get props => [];
}

class WatchlistAddMessage extends BlocWatchlistARState {
  final String message;

  const WatchlistAddMessage(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistRemoveMessage extends BlocWatchlistARState {
  final String message;

  const WatchlistRemoveMessage(this.message);

  @override
  List<Object> get props => [message];
}

class BlocWatchlistLoading extends BlocWatchlistARState {}

class BlocWatchlistEmpty extends BlocWatchlistARState {}

class BlocWatchlistError extends BlocWatchlistARState {
  final String message;

  const BlocWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}
