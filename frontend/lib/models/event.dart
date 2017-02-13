import 'package:intl/intl.dart';

class Event {
  final int id;
  final String url;
  String name;
  DateTime startDate;
  DateTime endDate;
  int raceCount;
  String raceUnratedOn;
  String organizer;
  String raceCommittee;
  String umpire;
  List<String> assistants;
  // entries
  // races

  Event(this.id, this.url,
      [this.name,
      this.startDate,
      this.endDate,
      this.raceCount,
      this.raceUnratedOn,
      this.organizer,
      this.raceCommittee,
      this.umpire,
      this.assistants]) {
    startDate ??= new DateTime.now();
    endDate ??= new DateTime.now();
  }

  factory Event.fromJson(Map<String, dynamic> event) => new Event(
      _toInt(event['id']),
      event['url'],
      event['name'],
      DateTime.parse(event['start_date']),
      DateTime.parse(event['end_date']),
      _toInt(event['race_count']),
      event['race_unrated_on'],
      event['organizer'],
      event['race_committee'],
      event['umpire'],
      event['assistants']);

  String get startDateStr {
    final DateFormat formatter = new DateFormat('yyyy-MM-dd');
    return formatter.format(startDate);
  }

  set startDateStr(String date) {
    startDate = DateTime.parse(date);
  }

  String get endDateStr {
    final DateFormat formatter = new DateFormat('yyyy-MM-dd');
    return formatter.format(endDate);
  }

  set endDateStr(String date) {
    endDate = DateTime.parse(date);
  }

  /// Clones this instance
  Event copy(
          {String name,
          DateTime startDate,
          DateTime endDate,
          int raceCount,
          String raceUnratedOn,
          String organizer,
          String raceCommittee,
          String umpire,
          List<String> assistants}) =>
      new Event(
          this.id,
          this.url,
          name ?? this.name,
          startDate ?? this.startDate,
          endDate ?? this.endDate,
          raceCount ?? this.raceCount,
          raceUnratedOn ?? this.raceUnratedOn,
          organizer ?? this.organizer,
          raceCommittee ?? this.raceCommittee,
          umpire ?? this.umpire,
          assistants ?? this.assistants);

  Map toJson() => {
        'id': id,
        'url': url,
        'name': name,
        'start_date': startDateStr,
        'end_date': endDateStr,
        'race_count': raceCount,
        'race_unrated_on': raceUnratedOn,
        'organizer': organizer,
        'race_committee': raceCommittee,
        'umpire': umpire,
        'assistants': assistants
      };

  @override
  String toString() => 'Event($name)';
}

int _toInt(id) => id is int ? id : int.parse(id);
