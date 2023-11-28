import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/domain/entities/advice_entity.dart';
import 'package:flutter_clean_architecture/domain/failures/failures.dart';
import 'package:flutter_clean_architecture/domain/repositories/advice_repo.dart';

class AdviceUsecases {
  final AdviceRepo adviceRepo;
  AdviceUsecases({required this.adviceRepo});

  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    // Call a repository to get data (failure or data)
    // Proceed with business logic (maipulate the data)
    // await Future.delayed(const Duration(seconds: 3), () {})
    // return const Right(AdviceEntity(
    //   advice: "Fake advice to test the bloc pattern",
    //   id: 1,
    // ));
    // return Left(ServerFailure());

    return adviceRepo.getAdviceFromDataSource();

    // Space for your buxiness logic
  }
}
