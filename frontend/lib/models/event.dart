import 'package:intl/intl.dart';

class Event {
  final String key;
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

  Event(this.key,
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

  factory Event.fromMap(key, Map<String, dynamic> event) => new Event(
      key,
      event['name'] ?? 'Unnamed',
      event['start_date'] != null ? DateTime.parse(event['start_date']) : new DateTime.now(),
      event['end_date'] != null ? DateTime.parse(event['end_date']) : new DateTime.now(),
      event['race_count'] != null ? _toInt(event['race_count']) : 1,
      event['race_unrated_on'],
      event['organizer'],
      event['race_committee'],
      event['umpire'],
      event['assistants']);

  Map toMap() => {
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
          this.key,
          name ?? this.name,
          startDate ?? this.startDate,
          endDate ?? this.endDate,
          raceCount ?? this.raceCount,
          raceUnratedOn ?? this.raceUnratedOn,
          organizer ?? this.organizer,
          raceCommittee ?? this.raceCommittee,
          umpire ?? this.umpire,
          assistants ?? this.assistants);

  @override
  String toString() => 'Event($name)';
}

int _toInt(id) => id is int ? id : int.parse(id);
