class Boat {
  final String key;
  String name;
  int yardstick;

  Boat(this.key, [this.name, this.yardstick]);

  factory Boat.fromMap(key, Map<String, dynamic> boat) =>
      new Boat(key, boat['name'], boat['yardstick'] != null ? _toInt(boat['yardstick']) : 100);

  Map toMap() => {'name': name, 'yardstick': yardstick};

  /// Clones this instance
  Boat copy({String name, int yardstick}) => new Boat(this.key, name ?? this.name, yardstick ?? this.yardstick);

  @override
  String toString() => 'Boat($name)';
}

int _toInt(id) => id is int ? id : int.parse(id);
