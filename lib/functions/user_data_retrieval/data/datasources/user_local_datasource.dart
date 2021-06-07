import '../../../../core/error/exceptions/exceptions.dart';
import '../../../../core/local_storage_manager/local_storage_manager.dart';
import 'user_data_source.dart';

class UserLocalDataSource extends UserDataSource {
  final LocalStorageManager _localStorageManager;
  UserLocalDataSource(
    this._localStorageManager,
  );

  @override
  Future<String?> getUsername() async {
    return _localStorageManager.getUsername();
  }

  @override
  Future<void> saveUsername(String username) async {
    final _res = await _localStorageManager.saveUsername(username);
    if (_res == false) throw LocalStorageException();
  }
}
