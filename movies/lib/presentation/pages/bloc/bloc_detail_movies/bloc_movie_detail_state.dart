import 'package:movies/movies.dart';

class BlocMovieDetailState extends Equatable {
  final MovieDetail? movieDetail;
  final List<Movie> movieRecommendations;
  final RequestState movieState;
  final RequestState recommendationState;
  final String message;
  final String watchlistMessage;
  final bool isAddedToWatchlist;

  const BlocMovieDetailState({
    required this.movieDetail,
    required this.movieRecommendations,
    required this.movieState,
    required this.recommendationState,
    required this.message,
    required this.watchlistMessage,
    required this.isAddedToWatchlist,
  });

  BlocMovieDetailState copyWith({
    MovieDetail? movieDetail,
    List<Movie>? movieRecommendations,
    RequestState? movieState,
    RequestState? recommendationState,
    String? message,
    String? watchlistMessage,
    bool? isAddedToWatchlist,
  }) {
    return BlocMovieDetailState(
      movieDetail: movieDetail ?? this.movieDetail,
      movieRecommendations: movieRecommendations ?? this.movieRecommendations,
      movieState: movieState ?? this.movieState,
      recommendationState: recommendationState ?? this.recommendationState,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
    );
  }

  factory BlocMovieDetailState.initial() {
    return const BlocMovieDetailState(
      movieDetail: null,
      movieRecommendations: [],
      movieState: RequestState.Empty,
      recommendationState: RequestState.Empty,
      message: '',
      watchlistMessage: '',
      isAddedToWatchlist: false,
    );
  }

  @override
  List<Object?> get props => [
        movieDetail,
        movieRecommendations,
        movieState,
        recommendationState,
        message,
        watchlistMessage,
        isAddedToWatchlist,
      ];
}
