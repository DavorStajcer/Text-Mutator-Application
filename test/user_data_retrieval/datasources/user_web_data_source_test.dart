//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

class MockFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockQueryDocumentSnapshot extends Mock
    implements QueryDocumentSnapshot<Map<String, dynamic>> {}

void main() {
  MockFirebaseAuth _mockFirebaseAuth;

  final String _testEmail = 'sljivica@gmail.com';
  final String _testPassword = 'jaka_sifra';
  final String _testUsername = 'awsome_user';

  // _setupWithUsername() {
  //   _mockFirebaseAuth = MockFirebaseAuth(
  //       mockUser: MockUser(displayName: _testUsername), signedIn: true);
  //   _userDataSourceImpl = UserDataSourceImpl(_mockFirebaseAuth);
  // }

  // _setupNoUsername() {
  //   _mockFirebaseAuth = MockFirebaseAuth(mockUser: MockUser(), signedIn: true);
  //   _userDataSourceImpl = UserDataSourceImpl(_mockFirebaseAuth);
  // }

  // test(
  //   'should return right username when there is one',
  //   () async {
  //     _setupWithUsername();
  //     // act
  //     final String _res = await _userDataSourceImpl.getUsername();
  //     // assert
  //     expect(_res, _testUsername);
  //   },
  // );
}
