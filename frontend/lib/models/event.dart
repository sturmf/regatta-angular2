import 'package:dson/dson.dart';
import 'package:intl/intl.dart';


@serializable
class Event {
  final int id;
  final String url;
  String name;
  DateTime _startDate; // replaced with custom formatter
  DateTime _endDate; // replaced with custom formatter
  @SerializedName("race_count")
  int raceCount;
  @SerializedName("race_unrated_on")
  String raceUnratedOn;
  String organizer;
  @SerializedName("race_committee")
  String raceCommittee;
  String umpire;
  @DsonType(String)
  Set<String> assistants;

  // entries
  // races

  Event(this.id, this.url, [
  this.name,
  this._startDate,
  this._endDate,
  this.raceCount,
  this.raceUnratedOn,
  this.organizer,
  this.raceCommittee,
  this.umpire,
  this.assistants
  ]);

  @SerializedName("start_date")
  String get startDate {
    final DateFormat formatter = new DateFormat('yyyy-MM-dd');
    return formatter.format(_startDate);
    //return _start_date.toIso8601String();
  }

  @SerializedName("start_date")
  set startDate(String date) {
    _startDate = DateTime.parse(date);
  }

  @SerializedName("end_date")
  String get endDate {
    final DateFormat formatter = new DateFormat('yyyy-MM-dd');
    return formatter.format(_endDate);
    //return _end_date.toIso8601String();
  }

  @SerializedName("end_date")
  set endDate(String date) {
    _endDate = DateTime.parse(date);
  }
}