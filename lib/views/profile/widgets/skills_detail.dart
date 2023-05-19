import 'package:flutter/material.dart';
import 'package:swifty_companion/models/user.model.dart';

import '../../../models/coalition.model.dart';

class SkillsDetail extends StatelessWidget {
  final User currentUser;
  final Coalition userCoalition;
  const SkillsDetail(
      {super.key, required this.currentUser, required this.userCoalition});

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
                'SKILLS DETAILS',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              currentUser.skills.isEmpty
                  ? const Text('No skills found')
                  : ListView(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      children: currentUser.skills
                          .map<Widget>((skill) => ListTile(
                                title: Text(
                                  skill.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                subtitle: Stack(
                                  children: [
                                    SizedBox(
                                      width: 370.0,
                                      height: 20,
                                      child: LinearProgressIndicator(
                                        value:
                                            skill.level - skill.level.toInt(),
                                        backgroundColor: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.8),
                                        valueColor: AlwaysStoppedAnimation(
                                            userCoalition.color
                                                .withOpacity(0.8)
                                                .withOpacity(0.8)),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 130.0, top: 2.0),
                                      child: Text(
                                        'level: ${skill.level.toInt().toString()} - ${((skill.level - skill.level.toInt()) * 100).round().toString()}%',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
