import 'package:flutter/material.dart';
import 'package:swifty_companion/models/project.model.dart';
import 'package:swifty_companion/models/user.model.dart';

class ProjectsDetail extends StatelessWidget {
  final User currentUser;
  final List<Project> currentProjects;

  const ProjectsDetail(
      {super.key, required this.currentUser, required this.currentProjects});

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
                            color: project.color,
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
