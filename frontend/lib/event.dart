class Event {
  final int id;
  String name;

  Event(this.id, this.name);

  factory Event.fromJson(Map<String, dynamic> event) =>
    new Event(_toInt(1), event['name']);

  Map toJson() => {'id': id, 'name': name};
}

int _toInt(id) => id is int ? id : int.parse(id);

