// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/api/auth_services.dart';
import 'package:frontend/global_handler.dart';

// Custom buildcontext class
class MockBuildContext extends BuildContext {
  @override
  InheritedElement get ancestorInheritedElement => throw UnimplementedError();

  @override
  BuildContext get baseWidgetDjType => throw UnimplementedError();

  @override
  void visitAncestorElements(bool Function(Element element) visitor) {
    throw UnimplementedError();
  }

  @override
  // TODO: implement debugDoingBuild
  bool get debugDoingBuild => throw UnimplementedError();

  @override
  InheritedWidget dependOnInheritedElement(InheritedElement ancestor,
      {Object? aspect}) {
    // TODO: implement dependOnInheritedElement
    throw UnimplementedError();
  }

  @override
  T? dependOnInheritedWidgetOfExactType<T extends InheritedWidget>(
      {Object? aspect}) {
    // TODO: implement dependOnInheritedWidgetOfExactType
    throw UnimplementedError();
  }

  @override
  DiagnosticsNode describeElement(String name,
      {DiagnosticsTreeStyle style = DiagnosticsTreeStyle.errorProperty}) {
    // TODO: implement describeElement
    throw UnimplementedError();
  }

  @override
  List<DiagnosticsNode> describeMissingAncestor(
      {required Type expectedAncestorType}) {
    // TODO: implement describeMissingAncestor
    throw UnimplementedError();
  }

  @override
  DiagnosticsNode describeOwnershipChain(String name) {
    // TODO: implement describeOwnershipChain
    throw UnimplementedError();
  }

  @override
  DiagnosticsNode describeWidget(String name,
      {DiagnosticsTreeStyle style = DiagnosticsTreeStyle.errorProperty}) {
    // TODO: implement describeWidget
    throw UnimplementedError();
  }

  @override
  void dispatchNotification(Notification notification) {
    // TODO: implement dispatchNotification
  }

  @override
  T? findAncestorRenderObjectOfType<T extends RenderObject>() {
    // TODO: implement findAncestorRenderObjectOfType
    throw UnimplementedError();
  }

  @override
  T? findAncestorStateOfType<T extends State<StatefulWidget>>() {
    // TODO: implement findAncestorStateOfType
    throw UnimplementedError();
  }

  @override
  T? findAncestorWidgetOfExactType<T extends Widget>() {
    // TODO: implement findAncestorWidgetOfExactType
    throw UnimplementedError();
  }

  @override
  RenderObject? findRenderObject() {
    // TODO: implement findRenderObject
    throw UnimplementedError();
  }

  @override
  T? findRootAncestorStateOfType<T extends State<StatefulWidget>>() {
    // TODO: implement findRootAncestorStateOfType
    throw UnimplementedError();
  }

  @override
  InheritedElement?
      getElementForInheritedWidgetOfExactType<T extends InheritedWidget>() {
    // TODO: implement getElementForInheritedWidgetOfExactType
    throw UnimplementedError();
  }

  @override
  T? getInheritedWidgetOfExactType<T extends InheritedWidget>() {
    // TODO: implement getInheritedWidgetOfExactType
    throw UnimplementedError();
  }

  @override
  // TODO: implement mounted
  bool get mounted => throw UnimplementedError();

  @override
  // TODO: implement owner
  BuildOwner? get owner => throw UnimplementedError();

  @override
  // TODO: implement size
  Size? get size => throw UnimplementedError();

  @override
  void visitChildElements(ElementVisitor visitor) {
    // TODO: implement visitChildElements
  }

  @override
  // TODO: implement widget
  Widget get widget => throw UnimplementedError();

  // Add other necessary overrides as needed for the context
}

void main() {
  // For registering user
  group('Authentication Tests', () {
    test('User Registration Test', () async {
      // Test user data
      final String username = 'test_user';
      final String email = 'test@example.com';
      final String password = 'test_password';
      final String confirmPassword = 'test_password';
      final mockContext = MockBuildContext();

      // Call the registerUser function with the test data and mock context
      await AuthServices.registerUser(
          username, email, password, confirmPassword, mockContext);

      // Verify that the user data is saved correctly
      final userData = await GlobalHandler.getUserData();
      expect(userData['username'], username);
      expect(userData['email'], email);
    });

    test('User Login Test', () async {
      // Test user credentials
      final String email = 'test@example.com';
      final String password = 'test_password';
      final mockContext = MockBuildContext();

      // Call the loginUser function with the test credentials and mock context
      await AuthServices.loginUser(email, password, mockContext);

      // Verify that the user data is saved correctly upon successful login
      final userData = await GlobalHandler.getUserData();
      expect(userData['email'], email);

      // Verify that the user is redirected to the appropriate screen after successful login
      expect(Navigator.of(mockContext).canPop(), true);
    });

    testWidgets(
        'Widget Test - Register User Screen', (WidgetTester tester) async {});

    testWidgets(
        'Widget Test - Login User Screen', (WidgetTester tester) async {});

    testWidgets('Integration Test - User Registration and Login',
        (WidgetTester tester) async {});
  });
}
