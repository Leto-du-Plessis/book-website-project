import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
import 'src/screens/test_screen.dart';
import 'src/models/app_state.dart';

void main() => runApp(
  ChangeNotifierProvider(
    create: (_) => AppState(),
    child: const MainApp()
  )
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      home: TestScreen(),
    );
  }
}
