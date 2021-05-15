//@dart=2.9
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:text_mutator/core/constants/enums.dart';
import 'package:text_mutator/core/constants/error_messages.dart';
import 'package:text_mutator/core/error/failures/failure.dart';
import 'package:text_mutator/functions/text_load/data/enteties/text_model.dart';
import 'package:text_mutator/functions/text_load/domain/models/text.dart';
import 'package:text_mutator/functions/text_load/domain/repsositories/text_repository.dart';
import 'package:text_mutator/functions/text_load/view/text_load_bloc/text_bloc.dart';
import 'package:text_mutator/functions/text_load/view/text_validation_bloc/textvalidator_bloc.dart';

class MockedTextRespository extends Mock implements TextRepository {}

class MockedTextValidatorBloc extends Mock implements TextValidatorBloc {}

void main() {
  MockedTextRespository _mockedTextRespository;
  MockedTextValidatorBloc _mockedTextValidatorBloc;

  setUp(() {
    _mockedTextRespository = MockedTextRespository();
    _mockedTextValidatorBloc = MockedTextValidatorBloc();
  });

  final TextDifficulty _testTextDifficulty = TextDifficulty.Easy;
  final TextModel _testTextModel = TextModel(
    'test',
    '',
    _testTextDifficulty,
  );
  final Text _testText = _testTextModel;

  void _setUpLoadSuccess() {
    when(_mockedTextRespository.loadText(_testTextDifficulty))
        .thenAnswer((_) async => Right(_testText));
  }

  void _setUpLoadFailure(Failure failure) {
    when(_mockedTextRespository.loadText(_testTextDifficulty))
        .thenAnswer((_) async => Left(failure));
  }

  void _setUpSaveSuccess() {
    when(_mockedTextRespository.saveText(_testTextModel))
        .thenAnswer((_) async => Right(null));
  }

  void _setUpSaveFailure(Failure failure) {
    when(_mockedTextRespository.saveText(_testTextModel))
        .thenAnswer((_) async => Left(failure));
  }

  group('loading text', () {
    blocTest(
      'should emit [TextLoading,TextLoaded] when succesfull',
      build: () {
        _setUpLoadSuccess();
        return TextBloc(_mockedTextRespository, _mockedTextValidatorBloc);
      },
      act: (bloc) => bloc.add(LoadText(textDifficulty: _testTextDifficulty)),
      expect: () => [TextLoading(), TextLoaded(_testText)],
    );

    blocTest(
      'should emit [TextError] when all text of that category read Wwith ERROR_TEXT_LOAD_ALL_TEXT_READ message',
      build: () {
        _setUpLoadFailure(AllTextsReadFailure());
        return TextBloc(_mockedTextRespository, _mockedTextValidatorBloc);
      },
      act: (bloc) => bloc.add(LoadText(textDifficulty: _testTextDifficulty)),
      expect: () => [TextLoading(), TextError(ERROR_TEXT_LOAD_ALL_TEXT_READ)],
    );

    blocTest(
      'should emit [TextError] with ERROR_SERVE_FAILURE when it goes wrong',
      build: () {
        _setUpLoadFailure(ServerFailure());
        return TextBloc(_mockedTextRespository, _mockedTextValidatorBloc);
      },
      act: (bloc) => bloc.add(LoadText(textDifficulty: _testTextDifficulty)),
      expect: () => [TextLoading(), TextError(ERROR_SERVER_FAILURE)],
    );

    blocTest(
      'should emit [TextError] with ERROR_NO_CONNECTION when not connected',
      build: () {
        _setUpLoadFailure(NoConnetionFailure());
        return TextBloc(_mockedTextRespository, _mockedTextValidatorBloc);
      },
      act: (bloc) => bloc.add(LoadText(textDifficulty: _testTextDifficulty)),
      expect: () => [TextLoading(), TextError(ERROR_NO_CONNECTION)],
    );
  });
  group('saving text', () {
    blocTest(
      'should emit [TextLoading, TextInitial] when succesfull',
      build: () {
        _setUpSaveSuccess();
        return TextBloc(_mockedTextRespository, _mockedTextValidatorBloc);
      },
      act: (bloc) => bloc.add(SaveText(_testText)),
      expect: () => [TextLoading(), TextInitial()],
    );

    blocTest(
      'should emit [TextLoading, TextError] with ERROR_NO_CONNECTION when not connected ',
      build: () {
        _setUpSaveFailure(NoConnetionFailure());
        return TextBloc(_mockedTextRespository, _mockedTextValidatorBloc);
      },
      act: (bloc) => bloc.add(SaveText(_testText)),
      expect: () => [TextLoading(), TextError(ERROR_NO_CONNECTION)],
    );

    blocTest(
      'should emit [TextLoading, TextError] with ERROR_SERVER_FAILURE when goes wrong ',
      build: () {
        _setUpSaveFailure(ServerFailure());
        return TextBloc(_mockedTextRespository, _mockedTextValidatorBloc);
      },
      act: (bloc) => bloc.add(SaveText(_testText)),
      expect: () => [TextLoading(), TextError(ERROR_SERVER_FAILURE)],
    );
  });
}
