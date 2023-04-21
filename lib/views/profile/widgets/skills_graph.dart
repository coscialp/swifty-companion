import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';

import 'package:swifty_companion/models/user.model.dart';

class SkillsGraph extends StatefulWidget {
  final User currentUser;
  const SkillsGraph({super.key, required this.currentUser});

  @override
  State<SkillsGraph> createState() =>
      _SkillsGraphState(currentUser: currentUser);
}

class _SkillsGraphState extends State<SkillsGraph> {
  final User currentUser;
  _SkillsGraphState({required this.currentUser});
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
                'SKILLS',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 300,
                child: RadarChart.light(
                  ticks: const [5, 10, 15, 20],
                  features: currentUser.skills
                      .map<String>((skill) => skill.name)
                      .toList(),
                  data: [
                    currentUser.skills.map((skill) => skill.level).toList()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
