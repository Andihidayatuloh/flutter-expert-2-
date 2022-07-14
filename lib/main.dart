import 'package:ditonton/main_library.dart';
import 'package:about/about.dart';
import 'package:movies/movies.dart';
import 'package:flutter/cupertino.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:provider/provider.dart';
import 'package:search/search.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<BlocMoviesListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<BlocMovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<BLocSearchMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<BlocPopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMoviesBloc>(),
        ),

        //tv
        BlocProvider(
          create: (_) => di.locator<BlocListTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<BlocTvDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<BlocTopTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<BlocPopularTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case MOVIE_HOME_PAGE:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case TV_HOME_PAGE:
              return CupertinoPageRoute(builder: (_) => TvPage());

            case MOVIE_POPULAR:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TV_POPULAR:
              return CupertinoPageRoute(builder: (_) => PopularTvPage());

            case MOVIE_TOP_RATED:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case TV_TOP_RATED:
              return CupertinoPageRoute(builder: (_) => TopRatedTvPage());

            case MOVIE_DETAIL:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case TV_DETAIL:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );

            case MOVIE_SEARCH:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case TV_SEARCH:
              return CupertinoPageRoute(builder: (_) => SearchTvPage());

            case MOVIE_WATCHLIST:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case TV_WATCHLIST:
              return MaterialPageRoute(builder: (_) => WatchlistTvPage());

            case ABOUT:
              return MaterialPageRoute(builder: (_) => AboutPage());

            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
