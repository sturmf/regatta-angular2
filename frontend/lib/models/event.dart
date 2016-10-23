import 'package:dson/dson.dart';
import 'package:intl/intl.dart';


@serializable
class Event {
  final int id;
  final String url;
  String name;
  DateTime _start_date; // replaced with custom formatter
  DateTime _end_date; // replaced with custom formatter
  int race_count;
  String race_unrated_on;
  String organizer;
  String race_committee;
  String umpire;

  @DsonType(String)
  Set<String> assistants;

  // entries
  // races

  Event(this.id, this.url, [
  this.name,
  this.startDate,
  this.endDate,
  this.race_count,
  this.race_unrated_on,
  this.organizer,
  this.race_committee,
  this.umpire,
  this.assistants
  ]);

  String get start_date {
    var formatter = new DateFormat('yyyy-MM-dd');
    return formatter.format(_start_date);
    //return _start_date.toIso8601String();
  }

  void set start_date(String date) {
    _start_date = DateTime.parse(date);
  }

  String get end_date {
    var formatter = new DateFormat('yyyy-MM-dd');
    return formatter.format(_end_date);
    //return _end_date.toIso8601String();
  }

  void set end_date(String date) {
    _end_date = DateTime.parse(date);
  }
}