import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'src/screens/home_screen.dart';
import 'src/models/app_state.dart';
import 'src/services/auth_repository.dart';
import 'src/services/auth_provider.dart';


void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => AppState(),
      ),
      Provider<AuthRepository>(
        create: (_) => AuthRepository(),
      ),
      ChangeNotifierProvider<AuthNotifier>(
        create: (context) => AuthNotifier(context.read<AuthRepository>()),
      ),
    ],
    child: const MainApp()
  )
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
