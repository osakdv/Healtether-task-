import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/user_model.dart';

// fetch user data from "https://jsonplaceholder.typicode.com/users";

class UsersDetaRequest {
  Future<List<UserModel>> getUsersDataRequest() async {
    const url = "https://jsonplaceholder.typicode.com/users";
    final uri = Uri.parse(url);
    final res = await http.get(uri);

    if (res.statusCode == 200) {
      final json = jsonDecode(res.body) as List;
      final users = json.map((e) {
        return UserModel(
            id: e["id"],
            name: e["name"],
            username: e["username"],
            email: e["email"],
            address: e["address"],
            phone: e["phone"],
            website: e["website"],
            company: e["company"]);
      }).toList();
      return users;
    } else {
      return [];
    }
  }
}
