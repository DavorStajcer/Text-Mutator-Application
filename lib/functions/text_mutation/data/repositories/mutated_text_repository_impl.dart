import 'dart:math';
import 'dart:developer' as dev;

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/error/failures/failure.dart';
import '../../../../core/network/connection_checker.dart';
import '../../../text_evaluation/domain/model/text_evalluation_model.dart';
import 'package:text_mutator/functions/text_load/domain/models/text.dart'
    as text;
import 'package:text_mutator/functions/text_mutation/data/datasources/network_data_source.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/word/clean_word.dart';
import 'package:text_mutator/functions/text_mutation/domain/models/word/mutated_word.dart';

import 'package:text_mutator/functions/text_mutation/domain/models/word/word.dart';
import 'package:text_mutator/functions/text_mutation/domain/repositories/mutated_text_repository.dart';

import '../../domain/models/mutated_text.dart';

class MutatedTextRepositoryImpl extends MutatedTextRepository {
  MutatedText? _mutatedText;
  final Random _random;
  final ConnectionChecker _connectionChecker;
  final NetworkMutatedWordsSource _networkMutatedWordsSource;

  MutatedTextRepositoryImpl(
    this._connectionChecker,
    this._networkMutatedWordsSource,
    this._random,
  );

  MutatedText get mutatedText => this._mutatedText!;

  void updateWord(Word word) {
    if (word is CleanWord) {
      final _index = _mutatedText!.cleanWords
          .indexWhere((element) => element.index == word.index);
      _mutatedText!.cleanWords[_index] = word;
    } else {
      final _index = _mutatedText!.mutatedWords
          .indexWhere((element) => element.index == word.index);
      _mutatedText!.mutatedWords[_index] = word as MutatedWord;
    }
  }

  @visibleForTesting
  List<CleanWord> parseText(String text) {
    List<CleanWord> _words = [];

    List<String> _verginWords = text.split(' ');

    for (int index = 0; index < _verginWords.length; index++) {
      _words.add(CleanWord(
        word: _verginWords.elementAt(index),
        index: index,
      ));
    }

    return _words;
  }

  final List<String> conjuctions = [
    'for',
    'and',
    'nor',
    'but',
    'or',
    'yet',
    'and',
    'so',
    'a',
    'the',
  ];

  //Ubacuje se broj mutiranih riječi po min(brojMutacija, duzinaTekstaZaMutiranje)
  Future<Either<Failure, MutatedText>> mutateText(
      TextEvaluationModel textEvaluationModel) async {
    if (!await _connectionChecker.hasConnection)
      return Left(NoConnetionFailure());
    try {
      final List<String> _mutations = [];
      int _numberOfMutationsFromServer =
          textEvaluationModel.maxNumberOfMutations;

      if (textEvaluationModel.includeConjuctions) {
        _numberOfMutationsFromServer = _calculateNumberOfConjuctionMutations(
            _numberOfMutationsFromServer, _mutations);
      }

      dev.log(_mutations.toString());
      _mutations.addAll(await _networkMutatedWordsSource
          .getWords(_numberOfMutationsFromServer));

      dev.log(_mutations.toString());
      _mutatedText = _mutateText(
        textEvaluationModel.text,
        _mutations,
        textEvaluationModel.resultDifficulty,
      );

      return Right(_mutatedText!);
    } catch (err) {
      return Left(ServerFailure());
    }
  }

  int _calculateNumberOfConjuctionMutations(
      int _numberOfMutationsFromServer, List<String> _mutations) {
    final Random _rand = Random();

    final int _numberOfMutationsFromConjuctions =
        (_numberOfMutationsFromServer * 0.1).ceil();

    for (var i = 0; i < _numberOfMutationsFromConjuctions; i++) {
      _mutations.add(
        conjuctions.elementAt(
          _rand.nextInt(conjuctions.length),
        ),
      );
    }

    _numberOfMutationsFromServer -= _numberOfMutationsFromConjuctions;
    return _numberOfMutationsFromServer;
  }

  MutatedText _mutateText(
      text.Text textToMutate, List<String> mutations, double resultDifficulty) {
    final List<int> _mutationIndexes = [];
    final List<MutatedWord> _mutatedWords = [];
    final List<CleanWord> _cleanWords = parseText(textToMutate.text);

    for (int i = 0; i < mutations.length && i < _cleanWords.length; i++) {
      //da se ne ponavljaju isti indexi, spriejčava da bude 4 instance mutated word, a samo 1 riječč da se prikaže je rimaju iste indekse
      int _newIndex = _random.nextInt(_cleanWords.length);

      while (_mutationIndexes.contains(_newIndex)) {
        _newIndex = _random.nextInt(_cleanWords.length);
      }
      _mutationIndexes.add(_newIndex);

      final String _randomWord = mutations[i];

      _mutatedWords
          .add(MutatedWord(word: _randomWord, index: _mutationIndexes[i]));
    }

    return MutatedText(
      _cleanWords,
      _mutatedWords,
      resultDifficulty,
    );
  }
}
