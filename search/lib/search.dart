library search;

export 'domain/movie/search_movies.dart';
export 'domain/tv/search_tv.dart';
export 'presentation/provider/movie/movie_search_notifier.dart';
export 'presentation/provider/tv/search_notifier_tv.dart';
export 'presentation/pages/movie/search_page.dart';
export 'presentation/pages/tv/search_page_tv.dart';



//bloc
export 'package:search/presentation/bloc/bloc_search_event.dart';
export 'package:search/presentation/bloc/bloc_search_state.dart';
export 'package:search/presentation/bloc/tv/bloc_search_tv_bloc.dart';
export 'package:search/presentation/bloc/movies/bloc_search_movies_bloc.dart';



//module
export 'package:movies/movies.dart';
// export 'package:tv/tv.dart';
export 'package:search/presentation/provider/tv/search_notifier_tv.dart';
export 'package:search/domain/movie/search_movies.dart';
export 'package:search/domain/tv/search_tv.dart';




//dependecies
export 'package:flutter/material.dart';
export 'package:provider/provider.dart';