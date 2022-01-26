import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/watchlist_data_source.dart';
import 'package:ditonton/domain/repositories/watchlist_repositories.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:movies/data/datasources/datasources.dart';
import 'package:tv/data/datasources/datasources.dart';

@GenerateMocks([
  MovieLocalDataSource,
  WatchlistRepository,
  WatchlistLocalDataSource,
  TVLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
