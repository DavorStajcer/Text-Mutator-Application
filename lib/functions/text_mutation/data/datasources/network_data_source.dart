import 'dart:convert';

import 'package:http/http.dart' as http;

const String BASE_ADDR = 'random-word-api.herokuapp.com';
const String BASE_PATH = '/word';

abstract class NetworkMutatedWordsSource {
  Future<List<String>> getWords(int wordCount);
}

class NetworkMutatedWordsSourceImpl extends NetworkMutatedWordsSource {
  final http.Client _client;

  NetworkMutatedWordsSourceImpl(this._client);

  @override
  Future<List<String>> getWords(int wordCount) async {
    final res = await _client
        .get(Uri.https(BASE_ADDR, BASE_PATH, {'number': wordCount.toString()}));
    final _words = jsonDecode(res.body).cast<String>();
    return _words;
  }
}
