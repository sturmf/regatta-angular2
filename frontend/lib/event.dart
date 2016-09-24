import 'package:intl/intl.dart';

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
  // assistants
  // entries
  // races


  Event(this.id, this.url, this.name, this.startDate, this.endDate,
      this.race_count, this.race_unrated_on, this.organizer,
      this.race_committee, this.umpire);

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

  factory Event.fromJson(Map<String, dynamic> event) =>
    new Event(_toInt(event['id']),
        event['url'],
        event['name'],
        DateTime.parse(event['start_date']),
        DateTime.parse(event['end_date']),
        _toInt(event['race_count']),
        event['race_unrated_on'],
        event['organizer'],
        event['race_committee'],
        event['umpire']
    );

  Map toJson() => {'id': id,
    'url': url,
    'name': name,
    'start_date': startDateStr,
    'end_date': endDateStr,
    'race_count': race_count,
    'race_unrated_on': race_unrated_on,
    'organizer': organizer,
    'race_committee': race_committee,
    'umpire': umpire
  };
}

int _toInt(id) => id is int ? id : int.parse(id);
