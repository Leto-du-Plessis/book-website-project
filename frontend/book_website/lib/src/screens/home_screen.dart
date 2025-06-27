import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';
import 'reader_screen.dart';
import '../models/app_state.dart';
import '../widgets/user_profile_image.dart';


class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});


  
  @override
  State<HomeScreen> createState() => _HomeScreen();
}


class _HomeScreen extends State<HomeScreen> {
  bool buttonstate = false;
  @override build(BuildContext context) {

    final imageBytes = context.watch<AppState>().profileImageBytes;
    
    return Scaffold( 
      appBar: AppBar( 
        title: const Text('Home'),
         actions: [
          IconButton(  
            icon: const Icon(Icons.book, size: 28),
            tooltip: 'Editor',
            onPressed: () {
              Navigator.push(  
                context,
                MaterialPageRoute(  
                  builder: (_) => const ReaderScreen(),
                ),
              );
            }
          ),
          IconButton(
            icon: 
              UserProfileImage(
                profileImageBytes: imageBytes,
                size: 40,
              ),
            tooltip: 'Login',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginScreen(),
                ),
              );
            },
          ),
          ElevatedButton(
            
            onPressed: () {setState(() { buttonstate = true;});
            },
            child: const Text('Search')
          )


        ],
      ),
      body:
        Center(
          child: Builder(
            builder:(context) {
            if(buttonstate == true) {
              return Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Text('Will be searching at some point')),
                  Align(
                    alignment: Alignment.topLeft,
                    child: ConstrainedBox(
                      
                      constraints: const BoxConstraints(maxHeight: 200, maxWidth: 200),
                      child: PlainCarousel()
                    
                    ) 
                    
                    
                  )  

                ]


              );
              
             
             } else {
              return PlainCarousel();
            }
            
            
            }
            )


          )
 );
      
      
      
    
  }
}


class PlainCarousel extends StatelessWidget {
  const PlainCarousel({super.key});

  @override 
  Widget build(BuildContext context) {
    return /* ListView(
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 200),
          child: CarouselView.weighted(
            
            itemSnapping: true,
            flexWeights: const <int>[1, 7, 1],
            children: [
              Center(child: Text('1')), Center(child: Text('2')), Center(child: Text('3'),)
            ]
          )
        )
      ]

    ); */

    
     Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [SizedBox(
          height: 200,
          width: 600,
            child: Container(
              padding:EdgeInsetsGeometry.fromLTRB(20,10,20,20),
              child: CarouselView(
                controller: CarouselController(),
                scrollDirection: Axis.horizontal,
                  backgroundColor: Colors.blueAccent,
                  itemExtent: 400,
                  
                  children: [Center(child: Text('1')),Center(child: Text('2')),Center(child: Text('3')),Center(child: Text('4')),Center(child: Text('5')),]
                  
                  
/*                   List<Widget>.generate(10, (int index) {
                    return Center
                      (child: Text('Item $index'),);
                      }), */
              ),
            ),
            ),
          ]
        ),
      )
    ); 
  }
}