import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:core/core.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetTVRecommendations {
  final TVRepository repository;

  GetTVRecommendations(this.repository);

  Future<Either<Failure, List<TV>>> execute(id) {
    return repository.getTVRecommendations(id);
  }
}
