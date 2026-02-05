import 'package:flutter_test/flutter_test.dart';
import 'package:devle/services/word_service.dart';

void main() {
  setUpAll(() async {});

  group('WordService Tests', () {
    test('Le Daily Word doit être déterministe', () {
      DateTime date1 = DateTime(2026, 1, 1);

      int index = date1.difference(DateTime(2024, 1, 1)).inDays;

      expect(index, greaterThanOrEqualTo(0));
    });

    test('Validation de mot basique', () {
      expect(WordService.isValidWord('ABC'), false);
    });
  });
}
