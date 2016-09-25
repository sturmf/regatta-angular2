class Person {
  final int id;
  final String url;
  String first_name;
  String last_name;
  String sailing_club;


  Person(this.id, this.url, this.first_name, this.last_name, this.sailing_club);

  factory Person.fromJson(Map<String, dynamic> data) =>
    new Person(_toInt(data['id']),
        data['url'],
        data['first_name'],
        data['last_name'],
        data['sailing_club']
    );

  Map toJson() => {'id': id,
    'url': url,
    'first_name': first_name,
    'last_name': last_name,
    'sailing_club': sailing_club,
  };
}

int _toInt(id) => id is int ? id : int.parse(id);
