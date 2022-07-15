library movies;

//data
export 'package:movies/data/datasources/movie_local_data_source.dart';
export 'package:movies/data/datasources/movie_remote_data_source.dart';
export 'package:movies/data/model/movie_model.dart';
export 'package:movies/data/model/movie_detail_model.dart';
export 'package:movies/data/model/movie_response.dart';
export 'package:movies/data/model/movie_table.dart';
export 'package:movies/data/repositories/movie_repository_impl.dart';

//domain
export 'package:movies/domain/entities/movie.dart';
export 'package:movies/domain/entities/movie_detail.dart';
export 'package:movies/domain/repositories/movie_repository.dart';
export 'package:movies/domain/usescase/get_movie_detail.dart';
export 'package:movies/domain/usescase/get_movie_recommendations.dart';
export 'package:movies/domain/usescase/get_now_playing_movies.dart';
export 'package:movies/domain/usescase/get_popular_movies.dart';
export 'package:movies/domain/usescase/get_top_rated_movies.dart';

//Page
export 'package:movies/presentation/pages/home_movie_page.dart';
export 'package:movies/presentation/pages/movie_detail_page.dart';
export 'package:movies/presentation/pages/popular_movies_page.dart';
export 'package:movies/presentation/pages/top_rated_movies_page.dart';

//watchlist
export 'package:movies/domain/usescase/watchlist/get_watchlist_movies.dart';
export 'package:movies/domain/usescase/watchlist/get_watchlist_status.dart';
export 'package:movies/domain/usescase/watchlist/remove_watchlist.dart';
export 'package:movies/domain/usescase/watchlist/save_watchlist.dart';
export 'package:movies/presentation/pages/watchlist_movies_page.dart';
export 'package:movies/presentation/bloc/bloc_watchlist_bloc.dart';

//presentation
export 'package:movies/presentation/bloc/bloc_movies_list_bloc.dart';
export 'package:movies/presentation/bloc/bloc_popular_movies_bloc.dart';
export 'package:movies/presentation/bloc/bloc_top_rated_movies.dart';
export 'package:movies/presentation/bloc/bloc_movie_detail_bloc.dart';

//widgets
export 'package:movies/presentation/widgets/movie_card_list.dart';

//dependencies
export 'package:flutter/material.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:cached_network_image/cached_network_image.dart';
export 'package:flutter_rating_bar/flutter_rating_bar.dart';
export 'package:equatable/equatable.dart';
