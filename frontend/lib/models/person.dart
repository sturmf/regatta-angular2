import 'package:dson/dson.dart';

@serializable
class Person {
  final int id;
  final String url;
  String first_name;
  String last_name;
  String sailing_club;


  Person(this.id, this.url, [this.first_name, this.last_name, this.sailing_club]);

  String get full_name => first_name + ' ' + last_name;
}
