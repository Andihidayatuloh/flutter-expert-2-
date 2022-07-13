library core;

//style 
export 'package:core/styles/colors.dart';
export 'package:core/styles/styles.dart';

//utils
export 'package:core/utils/constants.dart';
export 'package:core/utils/exception.dart';
export 'package:core/utils/failure.dart';
export 'package:core/utils/state_enum.dart';
export 'package:core/utils/route.dart';
export 'package:core/utils/utils.dart';


//domain
export 'package:core/domain/entities/movie.dart';
export 'package:core/domain/entities/genre.dart';
export 'package:core/domain/entities/movie_detail.dart';
export 'package:core/domain/entities/tv/tv.dart';
export 'package:core/domain/entities/tv/tv_detail.dart';
export 'package:core/domain/repositories/tv_repisitory.dart';
export 'package:core/domain/repositories/movie_repository.dart';


//presentation
export 'package:core/presentation/pages/drawer.dart';
export 'package:core/presentation/widgets/movie_card_list.dart';
export 'package:core/presentation/widgets/tv_card_list.dart';

//models movies
export 'package:core/data/models/movies/movie_detail_model.dart';
export 'package:core/data/models/movies/movie_model.dart';
export 'package:core/data/models/movies/movie_response.dart';
export 'package:core/data/models/movies/movie_table.dart';

//model tv
export 'package:core/data/models/tv/tv_detail.dart';
export 'package:core/data/models/tv/tv_model.dart';
export 'package:core/data/models/tv/tv_response.dart';
export 'package:core/data/models/tv/tv_table.dart';

//data
export 'package:core/data/datasources/db/databasetv.dart';
export 'package:core/data/datasources/db/database_helper.dart';
export 'package:core/data/datasources/movie_local_data_source.dart';
export 'package:core/data/datasources/movie_remote_data_source.dart';
export 'package:core/data/datasources/tv_data_source.dart';
export 'package:core/data/datasources/tv_remote_data_source.dart';

//repositories
export 'package:core/data/repositories/movie_repository_impl.dart';
export 'package:core/data/repositories/tv_repository_imp.dart';

//genre
export 'package:core/data/models/genre_model.dart';








