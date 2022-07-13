import 'package:tv/tv.dart';

class TvDetailState extends Equatable {
  final TvDetail? tvDetail;
  final List<Tv> tvRecommendations;
  final RequestState tvState;
  final RequestState recommendationState;
  final String message;
  final String watchlistMessage;
  final bool isAddedToWatchlist;

  const TvDetailState({
    required this.tvDetail,
    required this.tvRecommendations,
    required this.tvState,
    required this.recommendationState,
    required this.message,
    required this.watchlistMessage,
    required this.isAddedToWatchlist,
  });

  TvDetailState copyWith({
    TvDetail? tvDetail,
    List<Tv>? tvRecommendations,
    RequestState? tvState,
    RequestState? recommendationState,
    String? message,
    String? watchlistMessage,
    bool? isAddedToWatchlist,
  }) {
    return TvDetailState(
      tvDetail: tvDetail ?? this.tvDetail,
      tvRecommendations: tvRecommendations ?? this.tvRecommendations,
      tvState: tvState ?? this.tvState,
      recommendationState: recommendationState ?? this.recommendationState,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
    );
  }

  factory TvDetailState.initial() {
    return const TvDetailState(
      tvDetail: null,
      tvRecommendations: [],
      tvState: RequestState.Empty,
      recommendationState: RequestState.Empty,
      message: '',
      watchlistMessage: '',
      isAddedToWatchlist: false,
    );
  }

  @override
  List<Object?> get props => [
        tvDetail,
        tvRecommendations,
        tvState,
        recommendationState,
        message,
        watchlistMessage,
        isAddedToWatchlist,
      ];
}
