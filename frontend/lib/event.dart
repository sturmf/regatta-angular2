import 'package:intl/intl.dart';

class Event {
  final int id;
  final String url;
  String name;
  DateTime _startDate;

  Event(this.id, this.url, this.name, this._startDate);

  String get startDate {
    var formatter = new DateFormat('yyyy-MM-dd');
    return formatter.format(_startDate);
  }

  void set startDate(String date) {
    _startDate = DateTime.parse(date);
  }


  factory Event.fromJson(Map<String, dynamic> event) =>
    new Event(_toInt(event['id']), event['url'], event['name'], _toDateTime(event['start_date']));

  Map toJson() => {'id': id, 'url': url, 'name': name, 'start_date': startDate};
}

int _toInt(id) => id is int ? id : int.parse(id);

DateTime _toDateTime(dateTime) => DateTime.parse(dateTime);