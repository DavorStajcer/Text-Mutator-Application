abstract class NetworkMutatedWordsSource {
  Future<List<String>> getWords(int wordCount);
}

class NetworkMutatedWordsSourceImpl extends NetworkMutatedWordsSource {
  @override
  Future<List<String>> getWords(int wordCount) {
    // TODO: implement getWords
    throw UnimplementedError();
  }
}
