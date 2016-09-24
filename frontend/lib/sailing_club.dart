import 'package:intl/intl.dart';

class SailingClub {
  final int id;
  final String url;
  String name;
  String abbreviation;
  String registration;
  // was_organizer

  SailingClub(this.id, this.url, this.name, this.abbreviation, this.registration);

  factory SailingClub.fromJson(Map<String, dynamic> sailing_club) =>
    new SailingClub(_toInt(sailing_club['id']),
        sailing_club['url'],
        sailing_club['name'],
        sailing_club['abbreviation'],
        sailing_club['registration']
    );

  Map toJson() => {'id': id,
    'url': url,
    'name': name,
    'abbreviation': abbreviation,
    'registration': registration,
  };
}

int _toInt(id) => id is int ? id : int.parse(id);
