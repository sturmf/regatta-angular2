import 'package:intl/intl.dart';

class Event {
  final int id;
  final String url;
  String name;
  DateTime startDate;

  Event(this.id, this.url, this.name, this.startDate);

  String get startDateStr {
    var formatter = new DateFormat('yyyy-MM-dd');
    return formatter.format(startDate);
  }

  void set startDateStr(String date) {
    startDate = DateTime.parse(date);
  }


  factory Event.fromJson(Map<String, dynamic> event) =>
    new Event(_toInt(event['id']), event['url'], event['name'], DateTime.parse(event['start_date']));

  Map toJson() => {'id': id, 'url': url, 'name': name, 'start_date': startDateStr};
}

int _toInt(id) => id is int ? id : int.parse(id);
