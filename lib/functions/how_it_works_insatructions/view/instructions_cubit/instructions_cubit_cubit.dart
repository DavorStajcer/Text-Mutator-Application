import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'instructions_cubit_state.dart';

class InstructionsCubit extends Cubit<InstructionsCubitState> {
  InstructionsCubit() : super(InstructionsCubitInitial(0));
  void changePage(int pageIndex) => emit(InstructionPageChanged(pageIndex));
}
