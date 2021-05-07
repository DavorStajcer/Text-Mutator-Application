abstract class ConnectionChecker {
  Future<bool> get hasConnection;
}

class ConnectionCheckerImpl extends ConnectionChecker {
  @override
  Future<bool> get hasConnection => throw UnimplementedError();
}
