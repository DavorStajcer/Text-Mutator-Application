//@dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:text_mutator/core/constants/enums.dart';
import 'package:text_mutator/functions/text_load/data/datasources/network_data_source.dart';
import 'package:text_mutator/functions/text_load/data/enteties/text_model.dart';

class MockFirestore extends Mock implements FirebaseFirestore {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

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
  MockFirebaseAuth mockFirebaseAuth;
  NetworkTextDataSourceImpl _networkTextDataSource;

  setUp(() {
    _mockFirestore = MockFirestore();
    mockCollectionReference = MockCollectionReference();
    mockDocumentReference = MockDocumentReference();
    mockQueryDocumentSnapshot = MockQueryDocumentSnapshot();
    mockQuerySnapshot = MockQuerySnapshot();
    mockFirebaseAuth = MockFirebaseAuth();
    _networkTextDataSource =
        NetworkTextDataSourceImpl(_mockFirestore, mockFirebaseAuth);
  });
  final _testTextModel = TextModel('a', 'test', TextDifficulty.Easy);
  final _testTextMap = _testTextModel.toJson();

  void _setupFirestoreLoad() {
    when(_mockFirestore.collection(any)).thenReturn(mockCollectionReference);
    // when(mockDocumentReference.get())
    //     .thenAnswer((_) async => mockQueryDocumentSnapshot);
    when(mockCollectionReference.get())
        .thenAnswer((_) async => mockQuerySnapshot);
    when(mockQuerySnapshot.docs).thenReturn([mockQueryDocumentSnapshot]);
    when(mockQueryDocumentSnapshot.data()).thenReturn(_testTextMap);
  }

  void _setupSave() {
    when(_mockFirestore.collection(any)).thenReturn(mockCollectionReference);
    when(mockCollectionReference.add(_testTextMap))
        .thenAnswer((realInvocation) async => mockDocumentReference);
  }

  test(
    'should return right map object',
    () async {
      // arrange
      _setupFirestoreLoad();
      // act
      final res = await _networkTextDataSource.fetchText('easy', []);
      // assert
      expect(res, equals(_testTextMap));
    },
  );

  test(
    'should call add with right parameters',
    () async {
      // arrange
      _setupSave();
      // act
      await _networkTextDataSource.saveText(_testTextModel, 'easy');
      // assert
      verify(mockCollectionReference.add(_testTextMap)).called(1);
    },
  );
}
