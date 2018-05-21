import 'package:test/test.dart';
import 'package:frontend/services/algolia_service.dart';

void main() {

  test('check if Algolia query response contains hits', () async {
    final service = new AlgoliaService();
    final result = await service.search();
    print('Result: ${result}');
    expect(result, contains('hits'));
  });

}
