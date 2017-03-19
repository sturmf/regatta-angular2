import 'package:test/test.dart';
import 'package:frontend/models/boat.dart';

void main() {
  final dataJsonDefault = {'name': null, 'yardstick': null};

  final dataJson = {'name': 'H-Boat', 'yardstick': 106};

  test('serialize boat without parameters', () {
    final boat = new Boat('-K2ib4H77rj0LYewF7dP');
    final json = boat.toMap();
    expect(json, dataJsonDefault);
  });

  test('serialize boat with given parameters', () {
    final boat = new Boat('-K2ib4H77rj0LYewF7dP', 'H-Boat', 106);
    final json = boat.toMap();
    expect(json, dataJson);
  });

  test('deserialize and serialize roudtrip of boat', () {
    final boat = new Boat.fromMap('-K2ib4H77rj0LYewF7dP', dataJson);
    final json = boat.toMap();
    expect(json, dataJson);
  });
}
