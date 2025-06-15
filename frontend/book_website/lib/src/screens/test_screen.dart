import 'reader_screen.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.red,
              ),
            title: Container(
              padding:EdgeInsets.fromLTRB(20,0,0,0),
              child: Text('Test Screen', style:TextStyle(color: Colors.red, fontSize: 25),)),
            centerTitle: true,
            backgroundColor: Colors.black, 

        ),
        body: Center(
          child: Container(
            margin: EdgeInsetsGeometry.fromLTRB(250,10,250,50),
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            padding: EdgeInsetsGeometry.fromLTRB(25,10,25,10),
            child: ReaderScreen(),
          )
        )
     );
  }
}



class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text('Home'),
        centerTitle: true
        
        ),
      body: Padding(
          padding: const EdgeInsets.only(left:100, top:100),
          child: SizedBox(
                height: 50,
                width: 200,
            child: ElevatedButton(
              child: const Text('TestScreen'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TestScreen()),
                  );
                  },
          ),
        ),
      ),
    );
  
  }
}