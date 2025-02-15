import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './features/users/users_list_screen.dart';
import './services/provider/users_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UsersProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealTether Task',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: UsersListScreen.routePath,
      routes: {
        UsersListScreen.routePath: (_) => UsersListScreen(),
      },
    );
  }
}
