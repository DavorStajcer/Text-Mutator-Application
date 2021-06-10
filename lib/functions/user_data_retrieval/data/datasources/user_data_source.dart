abstract class UserDataSource {
  Future<String?> getUsername();
  Future<void> saveUsername(String username);
}
