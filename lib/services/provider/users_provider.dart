import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../request/users_data_request.dart';

class UsersProvider extends ChangeNotifier {
  bool isLoading = false;

  List<UserModel> _usersData = [];
  List<UserModel> get usersData => _usersData;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  // returns either a filtered data result or the orignal
  List<UserModel> get filteredUsersData {
    if (_searchQuery.isEmpty) {
      return _usersData;
    }
    return _usersData
        .where((user) =>
            user.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  // search functionality
  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // call the fetch request and updates the _userData var
  Future<void> fetchUsersData() async {
    isLoading = true;
    notifyListeners();

    try {
      final data = await UsersDetaRequest().getUsersDataRequest();
      _usersData = data;
    } catch (error) {
      print('Unknown error: $error');
      _errorMessage = 'Something went wrong. Please try again.';
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }

  // the refresh functionality, fetches more data when the user pull the screen to get more data
  // since the data from the endpoint is a static one, i manually simulate the process of adding new data
  Future<void> refreshUserData() async {
    await Future.delayed(const Duration(seconds: 2)); 
    _usersData.insert(
        0,
        UserModel(
          id: _usersData.length + 1,
          name: 'New Item ${DateTime.now().second}',
          email: 'newitem@example.com',
          username: "New"
        ));
    notifyListeners();
  }
}
