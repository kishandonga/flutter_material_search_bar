import 'dart:convert';

class City {
  String id;
  String name;
  String state;

  City({
    required this.id,
    required this.name,
    required this.state,
  });

  City copyWith({
    String? id,
    String? name,
    String? state,
  }) {
    return City(
      id: id ?? this.id,
      name: name ?? this.name,
      state: state ?? this.state,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'state': state,
    };
  }

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      state: map['state'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory City.fromJson(String source) => City.fromMap(json.decode(source));

  @override
  String toString() => 'City(id: $id, name: $name, state: $state)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is City &&
        other.id == id &&
        other.name == name &&
        other.state == state;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ state.hashCode;
}
