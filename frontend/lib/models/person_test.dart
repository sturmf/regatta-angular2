import 'package:test/test.dart';
import 'package:frontend/models/person.dart';

void main() {

  test('instantiate person', () {
    final person = new Person(2012,'myUrl', 'John', 'Doe', 'mySailingClub');
  });
}
