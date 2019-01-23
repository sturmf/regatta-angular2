class Person {
  Person(this.id, this.url, [this.firstName, this.lastName, this.sailingClub]);

  factory Person.fromJson(Map<String, dynamic> person) => new Person(
        person['id'],
        person['url'],
        person['first_name'],
        person['last_name'],
        person['sailing_club'],
      );

  final String id;
  final String url;
  String firstName;
  String lastName;
  String sailingClub;

  String get fullName => '$firstName $lastName';

  Map toJson() => {'id': id, 'url': url, 'first_name': firstName, 'last_name': lastName, 'sailing_club': sailingClub};

  @override
  String toString() => 'Person($fullName)';
}
