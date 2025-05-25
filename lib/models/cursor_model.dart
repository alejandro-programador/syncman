class Cursor {
  String name;
  Map<String, dynamic> value;

  Cursor({
    required this.name,
    required this.value,
  });

  factory Cursor.fromMap(Map<String, dynamic> json) {
    return Cursor(
      name: json['name'] as String,
      value: json['value'] as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'value': value,
    };
  }
}
