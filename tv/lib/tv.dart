library tv;

//domain
export 'package:tv/domain/usecases/get_now_play_tv.dart';
export 'package:tv/domain/usecases/get_popular_tv.dart';
export 'package:tv/domain/usecases/get_top_rated_tv.dart';
export 'package:tv/domain/usecases/get_tv_detail.dart';
export 'package:tv/domain/usecases/get_tv_recommendations.dart';

//watchlist
export 'package:tv/domain/usecases/watchlist/get_tv_wachtlist_status.dart';
export 'package:tv/domain/usecases/watchlist/get_wachlist_tv.dart';
export 'package:tv/domain/usecases/watchlist/remove_wachtlist.dart';
export 'package:tv/domain/usecases/watchlist/save_wachtlist.dart';

//presentation
  //bloc
export 'package:tv/presentation/bloc/bloc_card/bloc_tv_event.dart';
export 'package:tv/presentation/bloc/bloc_card/bloc_tv_state.dart';
export 'package:tv/presentation/bloc/bloc_card/bloc_list_tv_bloc.dart';
export 'package:tv/presentation/bloc/bloc_card/bloc_popular_tv_bloc.dart';
export 'package:tv/presentation/bloc/bloc_card/bloc_top_rated_tv_bloc.dart';

  //pages
export 'package:tv/presentation/pages/home_page_tv.dart';
export 'package:tv/presentation/pages/popular_page_tv.dart';
export 'package:tv/presentation/pages/top_rated_page_tv.dart';
export 'package:tv/presentation/pages/tv_detail_page.dart';

  //watchlist
export 'package:tv/presentation/pages/watchlist/wachtlist_page_tv.dart';
export 'package:tv/domain/usecases/watchlist/bloc/bloc_watchlist_event.dart';
export 'package:tv/domain/usecases/watchlist/bloc/bloc_watchlist_state.dart';
export 'package:tv/presentation/bloc/tv_detail/bloc_tv_detail_bloc.dart';
export 'package:tv/presentation/bloc/tv_detail/bloc_tv_detail_event.dart';
export 'package:tv/presentation/bloc/tv_detail/bloc_tv_detail_state.dart';
export 'package:tv/domain/usecases/watchlist/bloc/bloc_watchlist_bloc.dart';

// dependensis
export 'package:flutter/material.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:flutter/material.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:flutter_rating_bar/flutter_rating_bar.dart';
export 'package:cached_network_image/cached_network_image.dart';
export 'package:equatable/equatable.dart';

//modul
export 'package:core/core.dart';