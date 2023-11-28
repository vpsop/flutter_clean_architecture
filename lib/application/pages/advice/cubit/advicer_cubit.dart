import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'advicer_state.dart';

class AdvicerCubit extends Cubit<AdvicerCubitState> {
  AdvicerCubit() : super(AdvicerCubitInitial());


  void adviceRequestedEvent() {
    // Use functions inside cubit instead of Events...
  }
}
