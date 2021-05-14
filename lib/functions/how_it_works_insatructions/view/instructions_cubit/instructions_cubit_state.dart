part of 'instructions_cubit_cubit.dart';

abstract class InstructionsCubitState extends Equatable {
  final instructionPageIndex;
  const InstructionsCubitState(this.instructionPageIndex);

  @override
  List<Object> get props => [instructionPageIndex];
}

class InstructionsCubitInitial extends InstructionsCubitState {
  InstructionsCubitInitial(instructionPageIndex) : super(instructionPageIndex);
}

class InstructionPageChanged extends InstructionsCubitState {
  InstructionPageChanged(instructionPageIndex) : super(instructionPageIndex);
}
