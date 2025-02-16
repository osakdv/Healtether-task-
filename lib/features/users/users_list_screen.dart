import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/provider/users_provider.dart';
import './widgets/search_bar.dart' as custom;

class UsersListScreen extends StatefulWidget {
  static const routePath = "/users-list-screen";

  const UsersListScreen({Key? key}) : super(key: key);

  @override
  _UsersListScreenState createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UsersProvider>(context, listen: false).fetchUsersData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
      ),
      body: Consumer<UsersProvider>(
        builder: (context, usersProvider, child) {
          if (usersProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // if no data is returned
          if (usersProvider.usersData.isEmpty  || usersProvider.errorMessage != null) {
            return const Center(
              child: Text('No users found. Check your network connection.'),
            );
          }

          return RefreshIndicator(
            onRefresh: usersProvider.refreshUserData,
            child: Column(
              children: [
                custom.SearchBar(
                  onSearch: usersProvider.updateSearchQuery,
                  hintText: "Search by name",
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: usersProvider.filteredUsersData.length,
                    itemBuilder: (context, index) {
                      final user = usersProvider.filteredUsersData[index];
                      String avatarUrl = "https://robohash.org/$index";

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(avatarUrl),
                        ),
                        title: Text(user.name),
                        subtitle: Text(user.email),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
