class SailingClub {
  final String key;
  String name;
  String abbreviation;
  String registration;
  // was_organizer

  SailingClub(this.key, [this.name, this.abbreviation, this.registration]);

  factory SailingClub.fromMap(key, Map<String, dynamic> sailingClub) =>
      new SailingClub(key, sailingClub['name'], sailingClub['abbreviation'], sailingClub['registration']);

  Map toMap() => {'name': name, 'abbreviation': abbreviation, 'registration': registration};

  /// Clones this instance
  SailingClub copy({String name, String abbreviation, String registration}) => new SailingClub(
        this.key,
        name ?? this.name,
        abbreviation ?? this.abbreviation,
        registration ?? this.registration,
      );

  @override
  String toString() => 'SailingClub($name)';
}
