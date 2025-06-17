import 'package:flutter/material.dart';


class HomePage extends StatelessWidget{
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hopefully it worked"),
        centerTitle: true,
      ),
      body: NewScreenWidget()
      );


  }

}


class NewScreenWidget extends StatelessWidget{
  const NewScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        Widget page;
        switch (settings.name) {
          case '/':
            page = Page1();
            break;
          case '/page2':
            page = Page2();
            break;
          default:
            page = Page1();
        }
        return MaterialPageRoute(builder: (_) => page);
      },
    ); 
  }
}


class Page1 extends StatelessWidget {
  const Page1({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/page2');
        },
        child: Text("Go to Page 2"),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text("Back to Page 1"),
      ),
    );
  }
}