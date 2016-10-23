import 'package:dson/dson.dart';
import 'package:intl/intl.dart';


@serializable
class Event {
  final int id;
  final String url;
  String name;
  @SerializedName("start_date")
  DateTime startDate;
  @SerializedName("end_date")
  DateTime endDate;
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

  String get startDateStr {
    return startDate.toIso8601String();
  }

  void set startDateStr(String date) {
    startDate = DateTime.parse(date);
  }

  String get endDateStr {
    return endDate.toIso8601String();
  }

  void set endDateStr(String date) {
    endDate = DateTime.parse(date);
  }
}