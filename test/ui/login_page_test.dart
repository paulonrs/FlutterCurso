import 'package:flutter/material.dart';
import 'package:flutter_curso/ui/pages/pages.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Should load with correct initial state", (widgetTester) async {
    final loginPage = MaterialApp(home: LoginPage());
    await widgetTester.pumpWidget(loginPage);

    final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel('Email'), matching: find.byType(Text));
    expect(emailTextChildren, findsOneWidget,
        reason:
            'when a TextFormField has only text child, means it has no errors, since one of the childs is always the label text');

    final senhaTextChildren = find.descendant(
        of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));
    expect(senhaTextChildren, findsOneWidget,
        reason:
            'when a TextFormField has only text child, means it has no errors, since one of the childs is always the label text');

    final buttonLogin =
        widgetTester.widget<MaterialButton>(find.byType(MaterialButton));
    expect(buttonLogin.onPressed, null);
  });
}
