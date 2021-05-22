//@dart=2.9
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:text_mutator/functions/user_data_retrieval/data/user_data_source.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

void main() {
  UserDataSourceImpl _userDataSourceImpl;
  MockFirebaseAuth _mockFirebaseAuth;

  final String _testEmail = 'sljivica@gmail.com';
  final String _testPassword = 'jaka_sifra';

  setUp(() async {
    _mockFirebaseAuth = MockFirebaseAuth();
    _userDataSourceImpl = UserDataSourceImpl(_mockFirebaseAuth);

    final result = await _mockFirebaseAuth.signInWithEmailAndPassword(
      email: _testEmail,
      password: _testPassword,
    );
  });

  test(
    'should check if there is username available',
    () async {
      // arrange

      // act

      // assert
    },
  );
}
