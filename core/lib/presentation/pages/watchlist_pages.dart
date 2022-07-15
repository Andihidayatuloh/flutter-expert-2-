import 'package:core/core.dart';
import 'package:movies/movies.dart';
import 'package:tv/tv.dart';

class PagesWatchlist extends StatefulWidget {
  @override
  State<PagesWatchlist> createState() => _PagesWatchlist();
}

class _PagesWatchlist extends State<PagesWatchlist> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<WatchlistMoviesBloc>().add(BlocGetWatchlistMovies()));
    Future.microtask(
        () => context.read<WatchlistTvBloc>().add(BlocGetWatchlistTv()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    BlocProvider.of<WatchlistMoviesBloc>(context).add(BlocGetWatchlistMovies());
    BlocProvider.of<WatchlistTvBloc>(context).add(BlocGetWatchlistTv());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Watchlist Ditonton'),
          bottom: const TabBar(
            indicatorColor: kMikadoYellow,
            tabs: [
              Tab(text: 'Movies'),
              Tab(text: 'Televisi'),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: TabBarView(
            children: [
              WatchlistMoviesPage(),
              WatchlistTvPage(),
            ],
          ),
        ),
      ),
    );
  }
}
