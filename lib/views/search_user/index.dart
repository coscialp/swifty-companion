import 'package:flutter/material.dart';
import 'package:swifty_companion/modules/api_42.dart';
import 'package:swifty_companion/views/profile/profile_user.dart';

import '../../models/coalition.model.dart';
import '../../models/user.model.dart';

class SearchUserView extends StatefulWidget {
  const SearchUserView({super.key});

  @override
  State<SearchUserView> createState() => _SearchUserViewState();
}

class _SearchUserViewState extends State<SearchUserView> {
  List<String> foundUsers = [];
  User? currentUser;
  Coalition? userCoalition;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: currentUser != null
          ? AppBar(
              title: const Text('Go Back'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  currentUser = null;
                  setState(() {});
                },
              ))
          : null,
      body: currentUser != null
          ? ProfileView(
              currentUser: currentUser!,
              userCoalition: userCoalition!,
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            if (context.mounted) {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentMaterialBanner(
                                      reason:
                                          MaterialBannerClosedReason.dismiss);
                            }
                          },
                        ),
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () async {
                            foundUsers = await Api42.searchUserByLogin(
                                _searchController.text);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentMaterialBanner(
                                      reason:
                                          MaterialBannerClosedReason.dismiss);
                            }
                            setState(() {});
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        for (String user in foundUsers)
                          ListTile(
                            title: Text(user),
                            onTap: () async {
                              currentUser = await Api42.getUser(login: user);
                              if (currentUser == null && context.mounted) {
                                ScaffoldMessenger.of(context)
                                    .showMaterialBanner(MaterialBanner(
                                  padding: const EdgeInsets.all(20),
                                  content: const Text('User doesn\'t exist'),
                                  leading: const Icon(Icons.warning),
                                  backgroundColor: Colors.red,
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentMaterialBanner(
                                                reason:
                                                    MaterialBannerClosedReason
                                                        .dismiss);
                                      },
                                      child: const Text('DISMISS'),
                                    ),
                                  ],
                                ));
                              } else {
                                userCoalition = await Api42.getCoalition(
                                    currentUser!.login);
                              }
                              setState(() {});
                            },
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
