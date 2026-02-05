import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:devle/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:devle/services/word_service.dart';
import 'package:devle/widgets/key_button.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    WordService.testSetWords(['APPLE', 'BERRY', 'CODEZ']);
  });

  testWidgets('Test complet : Navigation vers Free Word et saisie clavier', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0;

    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // 1. Lancer l'application
    await tester.pumpWidget(const DevleApp());
    await tester.pumpAndSettle();

    // 2. Navigation
    expect(find.text('Free Word'), findsOneWidget);
    await tester.tap(find.text('Free Word'));
    await tester.pumpAndSettle();

    // 3. Vérification de l'écran de jeu
    expect(find.widgetWithText(KeyButton, 'A'), findsOneWidget);

    // 4. Saisie du mot "APPLE"
    await tester.tap(find.widgetWithText(KeyButton, 'A'));
    await tester.pump();

    await tester.tap(find.widgetWithText(KeyButton, 'P'));
    await tester.pump();

    await tester.tap(find.widgetWithText(KeyButton, 'P'));
    await tester.pump();

    await tester.tap(find.widgetWithText(KeyButton, 'L'));
    await tester.pump();

    await tester.tap(find.widgetWithText(KeyButton, 'E'));
    await tester.pump();

    // 5. Vérifier que les lettres sont dans la grille
    expect(find.text('A'), findsNWidgets(2));

    // 6. Valider
    await tester.tap(find.widgetWithText(KeyButton, 'ENT'));
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // 7. Vérification finale
    expect(find.text('Word not in dictionary!'), findsNothing);
  });
}
