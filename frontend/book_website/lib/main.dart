import 'package:flutter/material.dart';
//import 'package:flutter_quill/flutter_quill.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
import 'src/Screens/test_screen.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      home: TestScreen(),
      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   FlutterQuillLocalizations.delegate,
      // ],
    );
  }
}

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final QuillController _controller = QuillController.basic();
//   final FocusNode _focusNode = FocusNode();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Quill Example'),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             QuillSimpleToolbar(
//               controller: _controller,
//             ),
//             Expanded(
//               child: QuillEditor.basic(
//                 controller: _controller,
//                 focusNode: _focusNode,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _focusNode.dispose();
//     super.dispose();
//   }
// }