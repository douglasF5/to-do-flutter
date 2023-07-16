import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:to_do_flutter/services/auth.dart';

class MockUser extends Mock implements User {}

final MockUser _mockUser = MockUser();

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  Stream<User?> authStateChanges() {
    return Stream.fromIterable([_mockUser]);
  }
}

void main() {
  final MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
  final Auth auth = Auth(auth: mockFirebaseAuth);

  // Setup runs before the test
  setUp(() => {});

  // Setup runs after the test
  tearDown(() => {});

  // Tests
  test('emit occurs', () async {
    expectLater(auth.user, emitsInAnyOrder([_mockUser]));
  });

  // test("create account", () async {
  //   when(
  //     mockFirebaseAuth.createUserWithEmailAndPassword(
  //         email: "tadas@gmail.com", password: "123456"),
  //   ).thenAnswer((realInvocation) => 'user' as Future<UserCredential>);

  //   expect(
  //       await auth.createAccount(email: "tadas@gmail.com", password: "123456"),
  //       "Success");
  // });

  // test("create account exception", () async {
  //   when(
  //     mockFirebaseAuth.createUserWithEmailAndPassword(
  //         email: "tadas@gmail.com", password: "123456"),
  //   ).thenAnswer((realInvocation) => throw FirebaseAuthException(
  //       code: '000', message: 'Something went wrong'));

  //   expect(
  //       await auth.createAccount(email: "tadas@gmail.com", password: "123456"),
  //       'Something went wrong');
  // });
}
