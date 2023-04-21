import 'package:flutter/material.dart';
import 'package:swifty_companion/models/user.model.dart';
import 'package:swifty_companion/views/profile/widgets/profile_header.dart';
import 'package:swifty_companion/views/profile/widgets/projects_detail.dart';
import 'package:swifty_companion/views/profile/widgets/skills_detail.dart';
import 'package:swifty_companion/views/profile/widgets/skills_graph.dart';

class ProfileView extends StatefulWidget {
  final User currentUser;
  const ProfileView({super.key, required this.currentUser});

  @override
  State<ProfileView> createState() =>
      _ProfileViewState(currentUser: currentUser);
}

class _ProfileViewState extends State<ProfileView> {
  final User currentUser;

  _ProfileViewState({required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProfileHeader(currentUser: currentUser),
        SkillsGraph(currentUser: currentUser),
        SkillsDetail(currentUser: currentUser),
        ProjectsDetail(currentUser: currentUser),
      ],
    );
  }
}
