class Event {
  final int id;
  final String url;
  String name;

  Event(this.id, this.url, this.name);

  factory Event.fromJson(Map<String, dynamic> event) =>
    new Event(_toInt(event['id']), event['url'], event['name']);

  Map toJson() => {'id': id, 'url': url, 'name': name};
}

int _toInt(id) => id is int ? id : int.parse(id);

