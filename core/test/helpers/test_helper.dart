
import 'package:core/core.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  TvRepository,
  MovieRemoteDataSource,
  TvRemoteDataSource,
  MovieLocalDataSource,
  TvDataSource,
  DatabaseHelper,
  DatabaseTv,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
