import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:core/core.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetNowPlayingTV {
  final TVRepository repository;

  GetNowPlayingTV(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getNowPlayingTV();
  }
}
