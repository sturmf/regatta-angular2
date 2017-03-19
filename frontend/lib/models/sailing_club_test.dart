import 'package:test/test.dart';
import 'package:frontend/models/sailing_club.dart';

void main() {
  final dataJsonDefault = {'name': null, 'abbreviation': null, 'registration': null};

  final dataJson = {'name': 'Happy Sailing Club', 'abbreviation': 'HSC', 'registration': 'BA0815'};

  test('serialize sailingclub without parameters', () {
    final sailingClub = new SailingClub('-K2ib4H77rj0LYewF7dP');
    final json = sailingClub.toMap();
    expect(json, dataJsonDefault);
  });

  test('serialize sailingclub with given parameters', () {
    final sailingClub = new SailingClub('-K2ib4H77rj0LYewF7dP', 'Happy Sailing Club', 'HSC', 'BA0815');
    final json = sailingClub.toMap();
    expect(json, dataJson);
  });

  test('deserialize and serialize roudtrip of sailingclub', () {
    final sailingClub = new SailingClub.fromMap('-K2ib4H77rj0LYewF7dP', dataJson);
    final json = sailingClub.toMap();
    expect(json, dataJson);
  });
}
