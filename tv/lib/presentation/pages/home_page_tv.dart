import 'package:core/core.dart';
import 'package:tv/tv.dart';

class TvPage extends StatefulWidget {
  static const ROUTE_NAME = '/home-tv';
  @override
  _TvPageState createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<BlocTvListBloc>().add(BlocGetTvEvent());
      context.read<BlocPopularTvBloc>().add(BlocGetPopularTvEvent());
      context.read<TopRatedTvBloc>().add(BlocGetTopRatedTvEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('Movie'),
              onTap: () {
                Navigator.pushNamed(context, MOVIE_HOME_PAGE);
              },
            ),
            ListTile(
              leading: const Icon(Icons.live_tv),
              title: const Text('Tv Series'),
              onTap: () {
                Navigator.pushNamed(context, TV_HOME_PAGE);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WATCHLIST);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, ABOUT);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Televisi'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, TV_SEARCH);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading5,
              ),
              BlocBuilder<BlocTvListBloc, BlocTvState>(
                  builder: (context, state) {
                if (state is BlocTvLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is BlocTvLoaded) {
                  final result = state.result;
                  return TvList(result);
                } else if (state is BlocTvError) {
                  return Text(state.message);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular Tv',
                onTap: () => Navigator.pushNamed(context, TV_POPULAR),
              ),
              BlocBuilder<BlocPopularTvBloc, BlocPopularTvState>(
                  builder: (context, state) {
                if (state is BlocPopularTvLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is BlocPopularTvLoaded) {
                  final result = state.result;
                  return TvList(result);
                } else if (state is BlocPopularTvError) {
                  return Text(state.message);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated Tv',
                onTap: () => Navigator.pushNamed(context, TV_TOP_RATED),
              ),
              BlocBuilder<TopRatedTvBloc, BlocTopRatedTvState>(
                  builder: (context, state) {
                if (state is BlocTopRatedTvLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is BlocTopRatedTvLoaded) {
                  final result = state.result;
                  return TvList(result);
                } else if (state is BlocTopRatedTvError) {
                  return Text(state.message);
                } else {
                  return const Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> movies;

  TvList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
