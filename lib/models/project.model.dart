import 'package:flutter/material.dart';

class Project {
  late String name;
  late String status;
  late int? finalMark;
  late String cursusName;
  late Color color = Colors.grey;

  Project({
    required this.name,
    required this.status,
    required this.finalMark,
  });

  Project.fromJson(Map<String, dynamic> json) {
    if (json['project']['slug'].toString().contains('42cursus')) {
      cursusName = '42cursus';
    } else {
      cursusName = 'piscine-C';
    }
    name = json['project']['name'];
    status = json['status'];
    finalMark = json['final_mark'];

    if (status == 'in_progress' || status == 'searching_a_group') {
      color = Colors.orange;
    }
    if (status == 'finished') {
      color = finalMark != null && finalMark! >= 80 ? Colors.green : Colors.red;
    }
  }

  String toJson() {
    return '''{
      "name": "$name",
      "status": "$status",
      "final_mark": "$finalMark"
    }''';
  }
}
