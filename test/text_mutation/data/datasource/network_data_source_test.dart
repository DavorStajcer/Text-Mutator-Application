//@dart=2.9
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:text_mutator/functions/text_mutation/data/datasources/network_data_source.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  MockClient mockClient;
  NetworkMutatedWordsSourceImpl networkMutatedWordsSourceImpl;

  setUp(() {
    mockClient = MockClient();
    networkMutatedWordsSourceImpl = NetworkMutatedWordsSourceImpl(mockClient);
  });

  final int _testWordCount = 4;
  final List<String> _testWords = ['a', 'b', 'c', 'd'];
  final String _testResponse = '["a","b","c","d"]';

  final uri = Uri.https('random-word-api.herokuapp.com', '/word',
      {'number': _testWordCount.toString()});

  test(
    'should make GET request with right parameters and return the words ',
    () async {
      // arrange
      when(mockClient.get(uri))
          .thenAnswer((_) async => http.Response(_testResponse, 200));
      // act
      final res = await networkMutatedWordsSourceImpl.getWords(_testWordCount);
      // assert
      expect(res, equals(_testWords));
      verify(mockClient.get(uri)).called(1);
      verifyNoMoreInteractions(mockClient);
    },
  );
}
