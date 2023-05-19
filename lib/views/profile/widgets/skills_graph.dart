import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';

import 'package:swifty_companion/models/user.model.dart';

class SkillsGraph extends StatelessWidget {
  final User currentUser;
  const SkillsGraph({super.key, required this.currentUser});

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
              currentUser.skills.isEmpty
                  ? const Text('No skills found')
                  : SizedBox(
                      height: 300,
                      child: RadarChart.light(
                        ticks: const [5, 10, 15, 20],
                        features: currentUser.skills
                            .map<String>((skill) => skill.name)
                            .toList(),
                        data: [
                          currentUser.skills
                              .map((skill) => skill.level)
                              .toList()
                        ],
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
