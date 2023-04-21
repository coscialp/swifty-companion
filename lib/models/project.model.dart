class Project {
  late String name;
  late String status;
  late int? finalMark;
  late String cursusName;

  Project({
    required this.name,
    required this.status,
    required this.finalMark,
  });

  Project.fromJson(Map<String, dynamic> json) {
    if (json['project']['slug'].contains('42-cursus')) {
      cursusName = '42-cursus';
    } else {
      cursusName = 'piscine-C';
    }
    name = json['project']['name'];
    status = json['status'];
    finalMark = json['final_mark'];
  }

  String toJson() {
    return '''{
      "name": "$name",
      "status": "$status",
      "final_mark": "$finalMark"
    }''';
  }
}
