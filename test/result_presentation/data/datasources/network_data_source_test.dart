//@dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:text_mutator/functions/result_presentation/data/datasources/network_data_source.dart';

class MockFirestore extends Mock implements FirebaseFirestore {}

// class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockQueryDocumentSnapshot extends Mock
    implements QueryDocumentSnapshot<Map<String, dynamic>> {}

class MockQuerySnapshot extends Mock
    implements QuerySnapshot<Map<String, dynamic>> {}

void main() {
  MockFirestore _mockFirestore;
  MockFirebaseAuth _mockFirebaseAuth;
  MockQueryDocumentSnapshot mockQueryDocumentSnapshot;
  MockCollectionReference mockCollectionReference;
  MockDocumentReference mockDocumentReference;
  MockQuerySnapshot mockQuerySnapshot;
  NetworkResultDataSourceImpl networkResultDataSourceImpl;

  var user = MockUser(
    isAnonymous: false,
    uid: 'someuid',
    email: 'bob@somedomain.com',
    displayName: 'Bob',
  );

  setUp(() async {
    _mockFirestore = MockFirestore();
    // _mockFirebaseAuth = MockFirebaseAuth();
    mockCollectionReference = MockCollectionReference();
    mockDocumentReference = MockDocumentReference();
    mockQueryDocumentSnapshot = MockQueryDocumentSnapshot();
    mockQuerySnapshot = MockQuerySnapshot();

    _mockFirebaseAuth = MockFirebaseAuth();
    networkResultDataSourceImpl =
        NetworkResultDataSourceImpl(_mockFirestore, _mockFirebaseAuth);

    final result = await _mockFirebaseAuth.signInAnonymously();
    user = result.user;
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
    'list': [
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
    when(mockDocumentReference.collection(any))
        .thenReturn(mockCollectionReference);
    when(mockDocumentReference.get())
        .thenAnswer((_) async => mockQueryDocumentSnapshot);

    when(mockQueryDocumentSnapshot.data()).thenReturn(_testResultMap);
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
