import 'package:dson/dson.dart';
import 'package:intl/intl.dart';


@serializable
class Event {
  final int id;
  final String url;
  String name;
  @ignore
  DateTime startDate;
  @ignore
  DateTime endDate;
  int race_count;
  String race_unrated_on;
  String organizer;
  String race_committee;
  String umpire;
  List<String> assistants; // FIXME: should be a Set

  // entries
  // races


  Event(this.id, this.url, [this.name, this.startDate, this.endDate,
  this.race_count, this.race_unrated_on, this.organizer,
  this.race_committee, this.umpire, this.assistants]);

  @SerializedName("start_date")
  String get startDateStr {
    var formatter = new DateFormat('yyyy-MM-dd');
    return formatter.format(startDate);
    //return startDate.toIso8601String();
  }

  @SerializedName("start_date")
  void set startDateStr(String date) {
    startDate = DateTime.parse(date);
  }

  @SerializedName("end_date")
  String get endDateStr {
    var formatter = new DateFormat('yyyy-MM-dd');
    return formatter.format(endDate);
    //return endDate.toIso8601String();
  }

  @SerializedName("end_date")
  void set endDateStr(String date) {
    endDate = DateTime.parse(date);
  }
}