import 'package:dson/dson.dart';


@serializable
class SailingClub {
  final int id;
  final String url;
  String name;
  String abbreviation;
  String registration;
  // was_organizer


  SailingClub(this.id, this.url, [this.name, this.abbreviation, this.registration]);
}
