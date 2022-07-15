library tv;

//data
export 'package:tv/data/datasources/tv_data_source.dart';
export 'package:tv/data/datasources/tv_remote_data_source.dart';
export 'package:tv/data/model/tv_detail.dart';
export 'package:tv/data/model/tv_model.dart';
export 'package:tv/data/model/tv_response.dart';
export 'package:tv/data/model/tv_table.dart';
export 'package:tv/data/repositories/tv_repository_imp.dart';

//domain
export 'package:tv/domain/entities/tv.dart';
export 'package:tv/domain/entities/tv_detail.dart';
export 'package:tv/domain/repositories/tv_repisitory.dart';
export 'package:tv/domain/usecases/get_now_play_tv.dart';
export 'package:tv/domain/usecases/get_popular_tv.dart';
export 'package:tv/domain/usecases/get_top_rated_tv.dart';
export 'package:tv/domain/usecases/get_tv_detail.dart';
export 'package:tv/domain/usecases/get_tv_recommendations.dart';

//watchlist
export 'package:tv/domain/usecases/get_tv_wachtlist_status.dart';
export 'package:tv/domain/usecases/get_wachlist_tv.dart';
export 'package:tv/domain/usecases/remove_wachtlist.dart';
export 'package:tv/domain/usecases/save_wachtlist.dart';

//presentation
//bloc
export 'package:tv/presentation/bloc/bloc_list_tv_bloc.dart';
export 'package:tv/presentation/bloc/bloc_popular_tv_bloc.dart';
export 'package:tv/presentation/bloc/bloc_top_rated_tv_bloc.dart';

//pages
export 'package:tv/presentation/pages/home_page_tv.dart';
export 'package:tv/presentation/pages/popular_page_tv.dart';
export 'package:tv/presentation/pages/top_rated_page_tv.dart';
export 'package:tv/presentation/pages/tv_detail_page.dart';

//watchlist
export 'package:tv/presentation/pages/wachtlist_page_tv.dart';
export 'package:tv/presentation/bloc/bloc_tv_detail_bloc.dart';
export 'package:tv/presentation/bloc/bloc_watchlist_bloc.dart';

// widgets
export 'package:tv/presentation/widgets/tv_card_list.dart';

// dependency
export 'package:flutter/material.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:flutter/material.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:flutter_rating_bar/flutter_rating_bar.dart';
export 'package:cached_network_image/cached_network_image.dart';
export 'package:equatable/equatable.dart';
