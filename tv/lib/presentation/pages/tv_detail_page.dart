import 'package:core/core.dart';
import 'package:tv/tv.dart';

class TvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv';

  final int id;
  const TvDetailPage({required this.id});

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<BlocTvWatchlistStatus>(context)
          .add(LoadWatchlistTvStatus(widget.id));
      BlocProvider.of<BlocTvDetailBloc>(context).add(FetchTvDetail(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlocWatchlistTvAR, BlocTvWatchlistARState>(
      listenWhen: (_, state) =>
          state is TvWatchlistAddMessage ||
          state is TvWatchlistRemoveMessage ||
          state is BlocTvWatchlistError,
      listener: (context, state) {
        if (state is TvWatchlistAddMessage) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is TvWatchlistRemoveMessage) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is BlocTvWatchlistError) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text(state.message),
            ),
          );
        }
      },
      child: Scaffold(
        body: BlocBuilder<BlocTvDetailBloc, BlocTvDetailState>(
          builder: (_, data) =>
              BlocBuilder<BlocTvWatchlistStatus, BlocTvWatchlistStatusState>(
                  builder: (_, status) {
            if (data is BlocTvDetailLoaded && status is WatchlistTvStatus) {
              return SafeArea(
                  child: DetailContentTV(
                      data.movies, data.result, status.isAddedToWatchlist));
            } else if (data is BlocTvDetailError) {
              return Text(data.message);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ),
      ),
    );
  }
}

class DetailContentTV extends StatefulWidget {
  final TvDetail tv;
  final List<Tv> recommendations;
  final bool isAddedWatchlist;

  DetailContentTV(this.tv, this.recommendations, this.isAddedWatchlist);

  @override
  State<DetailContentTV> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContentTV> {
  late Season season;
  late int episode;

  @override
  void initState() {
    season = widget.tv.seasons[0];
    episode = widget.tv.seasons[0].episodeCount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${widget.tv.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.tv.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!widget.isAddedWatchlist) {
                                  context
                                      .read<BlocWatchlistTvAR>()
                                      .add(AddWatchlistTv(widget.tv));
                                  context
                                      .read<BlocTvWatchlistStatus>()
                                      .add(LoadWatchlistTvStatus(widget.tv.id));
                                } else {
                                  context
                                      .read<BlocWatchlistTvAR>()
                                      .add(RemoveFromWatchlistTv(widget.tv));
                                  context
                                      .read<BlocTvWatchlistStatus>()
                                      .add(LoadWatchlistTvStatus(widget.tv.id));
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  widget.isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(widget.tv.genres),
                            ),
                            widget.tv.episodeRunTime.isNotEmpty
                                ? Text(_showDuration(
                                    widget.tv.episodeRunTime.first))
                                : Container(),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.tv.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.tv.overview,
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton<Season>(
                                value: season,
                                items: widget.tv.seasons.map((e) {
                                  return DropdownMenuItem<Season>(
                                    value: e,
                                    child: Text('Season ${e.seasonNumber}'),
                                  );
                                }).toList(),
                                onChanged: (Season? newValue) {
                                  setState(() {
                                    season = newValue!;
                                    episode = newValue.episodeCount;
                                  });
                                },
                              ),
                            ),
                            Text("Total Eps : $episode"),
                            const SizedBox(height: 15),
                            Text(
                              "Recomendation",
                              style: kHeading6,
                            ),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final tv = widget.recommendations[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          TV_DETAIL,
                                          arguments: tv.id,
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: widget.recommendations.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
