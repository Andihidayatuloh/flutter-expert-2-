import 'package:core/data/datasources/db/databasetv.dart';
import 'package:core/data/models/tv/tv_table.dart';
import 'package:core/utils/exception.dart';


abstract class TvDataSource {
  Future<String> insertWatchlist(TvTable tv);
  Future<String> removeWatchlist(TvTable tv);
  Future<TvTable?> getTvById(int id);
  Future<List<TvTable>> getWatchlistTv();
}

class TvLocalDataSourceImpl implements TvDataSource {
  final DatabaseTv tvDatabaseHelperTv;

  TvLocalDataSourceImpl({required this.tvDatabaseHelperTv});

  @override
  Future<String> insertWatchlist(TvTable tv) async {
    try {
      await tvDatabaseHelperTv.insertWatchlist(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TvTable tv) async {
    try {
      await tvDatabaseHelperTv.removeWatchlist(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvTable?> getTvById(int id) async {
    final result = await tvDatabaseHelperTv.getTvById(id);
    if (result != null) {
      return TvTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvTable>> getWatchlistTv() async {
    final result = await tvDatabaseHelperTv.getWatchlistTv();
    return result.map((data) => TvTable.fromMap(data)).toList();
  }
}