class Skill {
  final String name;
  final double level;

  Skill.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        level = json['level'];

  String toJson() {
    return '''{
      "name": "$name",
      "level": "$level"
    }''';
  }
}
