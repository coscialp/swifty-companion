import 'package:flutter/material.dart';
import 'package:swifty_companion/models/user.model.dart';
import 'package:swifty_companion/modules/api_42.dart';

class SearchUserView extends StatefulWidget {
  const SearchUserView({super.key});

  @override
  State<SearchUserView> createState() => _SearchUserViewState();
}

class _SearchUserViewState extends State<SearchUserView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search...',
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => _searchController.clear(),
              ),
              prefixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () async {
                  List<String> foundUsers =
                      await Api42.searchUserByLogin(_searchController.text);
                  for (String user in foundUsers) {
                    debugPrint(user);
                  }
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
