//@dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:text_mutator/core/authentication/signed_user_provider.dart';
import 'package:text_mutator/functions/result_presentation/data/datasources/network_data_source.dart';

class MockFirestore extends Mock implements FirebaseFirestore {}

class MockSignedUserProvider extends Mock implements SignedUserProvider {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {}

class MockQuerySnapshot extends Mock
    implements QuerySnapshot<Map<String, dynamic>> {}

void main() {
  MockFirestore _mockFirestore;
  MockDocumentSnapshot mockDocumentSnapshot;
  MockSignedUserProvider _mockSignedUserProvider;
  MockCollectionReference mockCollectionReference;
  MockDocumentReference mockDocumentReference;
  MockQuerySnapshot mockQuerySnapshot;
  NetworkResultDataSourceImpl networkResultDataSourceImpl;

  setUp(() async {
    _mockFirestore = MockFirestore();
    // _mockFirebaseAuth = MockFirebaseAuth();
    mockCollectionReference = MockCollectionReference();
    mockDocumentReference = MockDocumentReference();
    mockDocumentSnapshot = MockDocumentSnapshot();
    mockQuerySnapshot = MockQuerySnapshot();
    _mockSignedUserProvider = MockSignedUserProvider();
    networkResultDataSourceImpl =
        NetworkResultDataSourceImpl(_mockFirestore, _mockSignedUserProvider);
  });

  final List<Map<String, dynamic>> _testResultList = [
    {
      'mutatedWords': 4,
      'wrongWords': 2,
      'numberOfMarkedWords': 4,
      'difficulty': 44,
      'id': 'testId',
    }
  ];

  final Map<String, dynamic> _testResultMap = {
    'results': [
      {
        'mutatedWords': 4,
        'wrongWords': 2,
        'numberOfMarkedWords': 4,
        'difficulty': 44,
        'id': 'testId',
      }
    ]
  };

  void _setupFirestoreLoad() {
    when(_mockFirestore.collection(any)).thenReturn(mockCollectionReference);
    when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);

    when(mockDocumentReference.get())
        .thenAnswer((_) async => mockDocumentSnapshot);
    when(mockDocumentSnapshot.data()).thenReturn(_testResultMap);

    when(_mockSignedUserProvider.getCurrentUserId()).thenReturn('someuid');
  }

  test(
    'should return appropriate reuslt map',
    () async {
      // arrange
      // _setupAuth();
      _setupFirestoreLoad();
      // act
      final res = await networkResultDataSourceImpl.fetchResults();
      // assert
      expect(res, equals(_testResultList));
    },
  );
}
