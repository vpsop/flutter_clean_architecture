import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/domain/failures/failures.dart';
import 'package:flutter_clean_architecture/domain/usecases/advice_usecases.dart';

part 'advicer_event.dart';
part 'advicer_state.dart';

class AdvicerBloc extends Bloc<AdvicerEvent, AdvicerState> {
  final AdviceUsecases adviceUseCases;
  // Could also use other use cases like signin or auth usecases
  AdvicerBloc({required this.adviceUseCases}) : super(AdvicerInitial()) {
    on<AdviceRequestedEvent>((event, emit) async {
      emit(AdvicerStateLoading());
      // execute business logic
      // for example get an advice
      // await Future.delayed(const Duration(seconds: 3), () {});
      final failureOrAdvice = await adviceUseCases.getAdvice();
      failureOrAdvice.fold(
        (failure) =>
            emit(AdvicerStateError(message: _mapFailureToMessage(failure))),
        (advice) => emit(AdvicerStateLoaded(advice: advice.advice)),
      );
    });
  }

  final unknownFailureMessage = 'Oops!, Something gone wrong.';
  final serverFailureMessage = 'API Error. Please try again!';
  final cacheFailureMessage = 'Cache failed. Please try again!';
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return unknownFailureMessage;
    }
  }
}
