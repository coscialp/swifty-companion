import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:swifty_companion/models/user.model.dart';

class ProfileHeader extends StatelessWidget {
  final User currentUser;

  const ProfileHeader({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/water_coalition_cover.png',
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: CircleAvatar(
                      radius: 78,
                      backgroundImage: NetworkImage(
                        currentUser.imageUrl,
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.only(left: 8.0),
                    elevation: 5,
                    color: Theme.of(context).primaryColor.withOpacity(0.8),
                    child: SizedBox(
                      width: 220,
                      height: 110,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${currentUser.firstName} ${currentUser.lastName}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              currentUser.login,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              currentUser.email,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Wallets: ${currentUser.wallets}₳',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 48.0),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: 390.0,
                          height: 30,
                          child: LinearProgressIndicator(
                            value:
                                currentUser.level - currentUser.level.toInt(),
                            backgroundColor:
                                Theme.of(context).primaryColor.withOpacity(0.8),
                            valueColor: AlwaysStoppedAnimation(
                                Colors.blue[400]?.withOpacity(0.8)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 160.0, top: 4.0),
                          child: Text(
                            'level: ${currentUser.level.toInt().toString()} - ${((currentUser.level - currentUser.level.toInt()) * 100).round().toString()}%',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
