import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:swifty_companion/models/project.model.dart';
import 'package:swifty_companion/models/user.model.dart';

class ProjectsDetail extends StatefulWidget {
  final User currentUser;
  const ProjectsDetail({super.key, required this.currentUser});

  @override
  State<ProjectsDetail> createState() =>
      _ProjectsDetailState(currentUser: currentUser);
}

class _ProjectsDetailState extends State<ProjectsDetail> {
  final User currentUser;
  List<Project> currentProjects = [];

  _ProjectsDetailState({required this.currentUser}) {
    for (Project project in currentUser.projects) {
      if (project.cursusName.contains('42-cursus')) {
        currentProjects.add(project);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                'PROJECTS',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              ListView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: currentProjects
                    .map<Widget>(
                      (project) => ListTile(
                        title: Text(
                          project.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          project.finalMark != null
                              ? '${project.status} - ${project.finalMark}%'
                              : project.status,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: project.status == 'in_progress' ||
                                    project.status == 'searching_a_group'
                                ? Colors.orange
                                : project.finalMark != null &&
                                        project.finalMark! >= 80
                                    ? Colors.green
                                    : Colors.red,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
