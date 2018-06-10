import 'package:test/test.dart';
import 'package:frontend/services/algolia_service.dart';

void main() {
  test('check if Algolia query response contains hits', () async {
    final service = new AlgoliaService();
    final result = await service.search('', 0, 5);
    expect(result, contains('hits'));
  });
}
