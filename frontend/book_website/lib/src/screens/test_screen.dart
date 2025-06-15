import 'reader_screen.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
            title: Text('Test Screen',), centerTitle: true,
        ),
        body: Center(
          child: Builder(
            builder: (context) {
              return ConstrainedBox(
                constraints: const BoxConstraints( maxHeight: 900, maxWidth:1180),
                child: Column(
                  children: [
                    Expanded(
                      child: ReaderScreen()
                    )
                  ]
                ),
                
              );
            }
          )
        )
     );
  }
}