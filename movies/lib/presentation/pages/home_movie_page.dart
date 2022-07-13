import 'package:movies/movies.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({Key? key}) : super(key: key);

  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<BlocMoviesListBloc>().add(BlocGetMoviesEvent());
      context.read<BlocPopularMoviesBloc>().add(BlocGetMoviesEvent());
      context.read<TopRatedMoviesBloc>().add(BlocGetMoviesEvent());
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
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pushNamed(context, MOVIE_HOME_PAGE);
              },
            ),
            ListTile(
              leading: const Icon(Icons.live_tv),
              title: const Text('Tv Shows'),
              onTap: () {
                Navigator.pushNamed(context, TV_HOME_PAGE);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Movie Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, MOVIE_WATCHLIST);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Tv Show Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, TV_WATCHLIST);
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
        title: const Text('Movies'),
        actions: [
          IconButton(
            onPressed: () {
              // FirebaseCrashlytics.instance.crash();
              Navigator.pushNamed(context, MOVIE_SEARCH);
            },
            icon: const Icon(Icons.search),
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
                style: kHeading6,
              ),
              BlocBuilder<BlocMoviesListBloc, BlocMoviesState>(builder: (context, state) {
                if (state is BlocMoviesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is BlocMoviesLoaded) {
                  final result = state.result;
                  return MovieList(result);
                } else if (state is BlocMoviesError) {
                  return Text(state.message);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(context, MOVIE_POPULAR),
              ),
              BlocBuilder<BlocPopularMoviesBloc, BlocMoviesState>(
                  builder: (context, state) {
                if (state is BlocMoviesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is BlocMoviesLoaded) {
                  final result = state.result;
                  return MovieList(result);
                } else if (state is BlocMoviesError) {
                  return Text(state.message);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(context, MOVIE_TOP_RATED),
              ),
              BlocBuilder<TopRatedMoviesBloc, BlocMoviesState>(
                  builder: (context, state) {
                if (state is BlocMoviesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is BlocMoviesLoaded) {
                  final result = state.result;
                  return MovieList(result);
                } else if (state is BlocMoviesError) {
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
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MOVIE_DETAIL,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
