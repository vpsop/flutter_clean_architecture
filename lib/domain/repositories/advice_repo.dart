import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/domain/entities/advice_entity.dart';
import 'package:flutter_clean_architecture/domain/failures/failures.dart';

abstract class AdviceRepo {
  Future<Either<Failure, AdviceEntity>> getAdviceFromDataSource();
}
