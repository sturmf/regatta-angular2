class SailingClub {
  final int id;
  final String url;
  String name;
  String abbreviation;
  String registration;
  // was_organizer

  SailingClub(this.id, this.url, [this.name, this.abbreviation, this.registration]);

  factory SailingClub.fromJson(Map<String, dynamic> sailingClub) => new SailingClub(
        _toInt(sailingClub['id']),
        sailingClub['url'],
        sailingClub['name'],
        sailingClub['abbreviation'],
        sailingClub['registration'],
      );

  Map toJson() => {'id': id, 'url': url, 'name': name, 'abbreviation': abbreviation, 'registration': registration};
}

int _toInt(id) => id is int ? id : int.parse(id);
