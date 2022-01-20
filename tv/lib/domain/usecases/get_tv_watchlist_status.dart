import 'package:tv/domain/repositories/tv_repository.dart';

class GetTVWatchListStatus {
  final TVRepository repository;

  GetTVWatchListStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
