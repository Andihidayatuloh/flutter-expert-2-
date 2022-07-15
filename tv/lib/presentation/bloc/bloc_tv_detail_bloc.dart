import 'package:tv/tv.dart';

// Detail Bloc
class BlocTvDetailBloc extends Bloc<BlocTvDetailEvent, BlocTvDetailState> {
  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;

  BlocTvDetailBloc({
    required this.getTvDetail,
    required this.getTvRecommendations,
  }) : super((BlocTvDetailEmpty())) {
    on<FetchTvDetail>((event, emit) async {
      final id = event.id;
      emit(BlocTvDetailLoading());

      final detail = await getTvDetail.execute(id);
      final recommendation = await getTvRecommendations.execute(id);

      detail.fold((failure) => emit(BlocTvDetailError(failure.message)),
          (dataDetail) {
        emit(BlocTvDetailLoading());

        recommendation.fold(
            (failure) => emit(BlocTvDetailError(failure.message)),
            (dataRecommendations) =>
                emit(BlocTvDetailLoaded(dataDetail, dataRecommendations)));
      });
    });
  }
}

// Bloc Watchlist Status
class BlocTvWatchlistStatus
    extends Bloc<BlocTvWatchlistStatusEvent, BlocTvWatchlistStatusState> {
  final GetWatchListStatusTv getWatchListStatus;

  BlocTvWatchlistStatus({required this.getWatchListStatus})
      : super((BlocTvWatchlistStatusEmpty())) {
    on<LoadWatchlistTvStatus>(
      (event, emit) async {
        emit(BlocTvWatchlistStatusLoading());
        final id = event.id;

        final result = await getWatchListStatus.execute(id);
        emit(WatchlistTvStatus(result));
      },
    );
  }
}

// Bloc Add & Remove Watchlist
class BlocWatchlistTvAR
    extends Bloc<BlocTvWatchlistAREvent, BlocTvWatchlistARState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final SaveWatchlistTv saveWatchlist;
  final RemoveWatchlistTv removeWatchlist;

  BlocWatchlistTvAR({
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super((BloTvWatchlistEmpty())) {
    on<AddWatchlistTv>(
      (event, emit) async {
        emit(BlocTvWatchlistLoading());
        final movie = event.movieDetail;
        final result = await saveWatchlist.execute(movie);

        result.fold(
          (failure) => emit(BlocTvWatchlistError(failure.message)),
          (data) => emit(TvWatchlistAddMessage(data)),
        );
      },
    );

    on<RemoveFromWatchlistTv>(
      (event, emit) async {
        emit(BlocTvWatchlistLoading());
        final movie = event.movieDetail;
        final result = await removeWatchlist.execute(movie);

        result.fold(
          (failure) => emit(BlocTvWatchlistError(failure.message)),
          (data) => emit(TvWatchlistRemoveMessage(data)),
        );
      },
    );
  }
}

// Bloc Tv Detail Event
abstract class BlocTvDetailEvent extends Equatable {
  const BlocTvDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchTvDetail extends BlocTvDetailEvent {
  final int id;

  const FetchTvDetail(this.id);

  @override
  List<Object> get props => [id];
}

// Bloc Tv Detail State
abstract class BlocTvDetailState extends Equatable {
  const BlocTvDetailState();

  @override
  List<Object> get props => [];
}

class BlocTvDetailEmpty extends BlocTvDetailState {}

class BlocTvDetailLoading extends BlocTvDetailState {}

class BlocTvDetailError extends BlocTvDetailState {
  final String message;

  const BlocTvDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class BlocTvDetailLoaded extends BlocTvDetailState {
  final TvDetail movies;
  final List<Tv> result;

  const BlocTvDetailLoaded(this.movies, this.result);

  @override
  List<Object> get props => [result, movies];
}

// Bloc Watchlist Status Event
abstract class BlocTvWatchlistStatusEvent extends Equatable {
  const BlocTvWatchlistStatusEvent();

  @override
  List<Object> get props => [];
}

class LoadWatchlistTvStatus extends BlocTvWatchlistStatusEvent {
  final int id;

  const LoadWatchlistTvStatus(this.id);

  @override
  List<Object> get props => [id];
}

// Blocw Watchlist Status State
abstract class BlocTvWatchlistStatusState extends Equatable {
  const BlocTvWatchlistStatusState();

  @override
  List<Object> get props => [];
}

class BlocTvWatchlistStatusLoading extends BlocTvWatchlistStatusState {}

class BlocTvWatchlistStatusEmpty extends BlocTvWatchlistStatusState {}

class WatchlistTvStatus extends BlocTvWatchlistStatusState {
  final bool isAddedToWatchlist;

  const WatchlistTvStatus(this.isAddedToWatchlist);

  @override
  List<Object> get props => [isAddedToWatchlist];
}

// Bloc Watchlist Add & Remove Event
abstract class BlocTvWatchlistAREvent extends Equatable {
  const BlocTvWatchlistAREvent();

  @override
  List<Object> get props => [];
}

class AddWatchlistTv extends BlocTvWatchlistAREvent {
  final TvDetail movieDetail;

  const AddWatchlistTv(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class RemoveFromWatchlistTv extends BlocTvWatchlistAREvent {
  final TvDetail movieDetail;

  const RemoveFromWatchlistTv(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

// Bloc Watchlist Add & Remove State
abstract class BlocTvWatchlistARState extends Equatable {
  const BlocTvWatchlistARState();

  @override
  List<Object> get props => [];
}

class TvWatchlistAddMessage extends BlocTvWatchlistARState {
  final String message;

  const TvWatchlistAddMessage(this.message);

  @override
  List<Object> get props => [message];
}

class TvWatchlistRemoveMessage extends BlocTvWatchlistARState {
  final String message;

  const TvWatchlistRemoveMessage(this.message);

  @override
  List<Object> get props => [message];
}

class BlocTvWatchlistLoading extends BlocTvWatchlistARState {}

class BloTvWatchlistEmpty extends BlocTvWatchlistARState {}

class BlocTvWatchlistError extends BlocTvWatchlistARState {
  final String message;

  const BlocTvWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}
