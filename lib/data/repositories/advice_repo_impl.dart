import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/data/datasources/advice_remote_datasource.dart';
import 'package:flutter_clean_architecture/data/exceptions/exceptions.dart';
import 'package:flutter_clean_architecture/domain/entities/advice_entity.dart';
import 'package:flutter_clean_architecture/domain/failures/failures.dart';
import 'package:flutter_clean_architecture/domain/repositories/advice_repo.dart';

class AdviceRepoImpl implements AdviceRepo {
  final AdviceRemoteDataSource adviceRemoteDataSource;
  AdviceRepoImpl({required this.adviceRemoteDataSource});

  
  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromDataSource() async {
    try {
      final result = await adviceRemoteDataSource.getRandomAdviceFromApi();
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } on CacheException catch (_) {
      return left(CacheFailure());
    } catch (exception) {
      // Handle the exceptions
      return left(UnknownFailure());
    }
  }
}
