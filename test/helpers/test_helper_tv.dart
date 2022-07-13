import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/tv_data_source.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';

import 'package:ditonton/domain/repositories/tv_repisitory.dart';

import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  TvRepository,
  TvRemoteDataSource,
  TvDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
