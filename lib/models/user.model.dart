import 'package:swifty_companion/models/coalition.model.dart';
import 'package:swifty_companion/models/project.model.dart';
import 'package:swifty_companion/models/skills.model.dart';

class User {
  final String firstName;
  final String lastName;
  final String login;
  final String email;
  final String imageUrl;
  final String wallets;
  final double level;
  final List<Project> projects;
  final String correctionPoints;
  final List<Skill> skills;
  late Coalition coalition;

  User.fromJson(Map<String, dynamic> json)
      : firstName = json['first_name'],
        lastName = json['last_name'],
        login = json['login'],
        email = json['email'],
        imageUrl = json['image']['link'],
        wallets = json['wallet'].toString(),
        level = json['cursus_users'][1]['level'],
        projects = json['projects_users']
            .map<Project>((project) => Project.fromJson(project))
            .toList(),
        correctionPoints = json['correction_point'].toString(),
        skills = json['cursus_users'][1]['skills']
            .map<Skill>((skill) => Skill.fromJson(skill))
            .toList();

  String toJson() {
    return '''{
      "first_name": "$firstName",
      "last_name": "$lastName",
      "login": "$login",
      "email": "$email",
      "image_url": "$imageUrl",
      "wallets": "$wallets",
      "level": "$level",
      "projects": ${projects.map((project) => project.toJson()).toList()},
      "skills": ${skills.map((skill) => skill.toJson()).toList()},
      "correction_points": "$correctionPoints"
    }''';
  }
}
