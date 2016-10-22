import 'package:intl/intl.dart';

import 'person.dart';


class Event {
  final int id;
  final String url;
  String name;
  DateTime startDate;
  DateTime endDate;
  int race_count;
  String race_unrated_on;
  String organizer;
  String race_committee;
  String umpire;
  Set<String> assistants;
  // entries
  // races


  Event({this.id: -1, this.url: null, this.name, this.startDate, this.endDate,
      this.race_count, this.race_unrated_on, this.organizer,
      this.race_committee, this.umpire, this.assistants});

  String get startDateStr {
    var formatter = new DateFormat('yyyy-MM-dd');
    return formatter.format(startDate);
  }

  void set startDateStr(String date) {
    startDate = DateTime.parse(date);
  }

  String get endDateStr {
    var formatter = new DateFormat('yyyy-MM-dd');
    return formatter.format(endDate);
  }

  void set endDateStr(String date) {
    endDate = DateTime.parse(date);
  }

  // FIXME: remove
  factory Event.fromJson(Map<String, dynamic> event) =>
    new Event(id: _toInt(event['id']),
        url: event['url'],
        name: event['name'],
        startDate: DateTime.parse(event['start_date']),
        endDate: DateTime.parse(event['end_date']),
        race_count: _toInt(event['race_count']),
        race_unrated_on: event['race_unrated_on'],
        organizer: event['organizer'],
        race_committee: event['race_committee'],
        umpire: event['umpire'],
        assistants: event['assistants']
    );

  // FIXME: remove
  Map toJson() => {'id': id,
    'url': url,
    'name': name,
    'start_date': startDateStr,
    'end_date': endDateStr,
    'race_count': race_count,
    'race_unrated_on': race_unrated_on,
    'organizer': organizer,
    'race_committee': race_committee,
    'umpire': umpire,
    'assistants': assistants
  };
}

// FIXME: remove
int _toInt(id) => id is int ? id : int.parse(id);
