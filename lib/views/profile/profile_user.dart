import 'package:flutter/material.dart';
import 'package:swifty_companion/models/coalition.model.dart';
import 'package:swifty_companion/models/project.model.dart';
import 'package:swifty_companion/models/user.model.dart';
import 'package:swifty_companion/modules/api_42.dart';
import 'package:swifty_companion/views/profile/widgets/profile_header.dart';
import 'package:swifty_companion/views/profile/widgets/projects_detail.dart';
import 'package:swifty_companion/views/profile/widgets/skills_detail.dart';
import 'package:swifty_companion/views/profile/widgets/skills_graph.dart';

class ProfileView extends StatefulWidget {
  final User currentUser;
  final Coalition userCoalition;
  const ProfileView(
      {super.key, required this.currentUser, required this.userCoalition});

  @override
  State<ProfileView> createState() =>
      _ProfileViewState(currentUser: currentUser, userCoalition: userCoalition);
}

class _ProfileViewState extends State<ProfileView> {
  final User currentUser;
  final Coalition userCoalition;
  List<Project> currentProjects = [];

  _ProfileViewState({required this.currentUser, required this.userCoalition}) {
    for (Project project in currentUser.projects) {
      if (project.cursusName == '42cursus') {
        currentProjects.add(project);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).hideCurrentMaterialBanner(
          reason: MaterialBannerClosedReason.dismiss);
    }
    return ListView(
      children: [
        ProfileHeader(currentUser: currentUser, userCoalition: userCoalition),
        SkillsGraph(currentUser: currentUser),
        SkillsDetail(currentUser: currentUser, userCoalition: userCoalition),
        ProjectsDetail(
            currentUser: currentUser, currentProjects: currentProjects),
      ],
    );
  }
}
