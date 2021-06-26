import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class ConnectionChecker {
  Future<bool> get hasConnection;
}

class ConnectionCheckerImpl extends ConnectionChecker {
  final InternetConnectionChecker _internetConnectionChecker;

  ConnectionCheckerImpl(this._internetConnectionChecker);

  @override
  Future<bool> get hasConnection async {
    if (kIsWeb) return true;
    return await _internetConnectionChecker.hasConnection;
  }
}
