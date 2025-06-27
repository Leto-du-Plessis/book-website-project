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
              return Text('Will be searching at some point');
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
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [SizedBox(
          height: 200,
          width: 200,
            child: Container(
              padding:EdgeInsetsGeometry.fromLTRB(20,10,20,20),
              child: CarouselView(
                scrollDirection: Axis.horizontal,
                  backgroundColor: Colors.blueAccent,
                  itemExtent: 200,
                  
                  children: [
                      Center(child: Text('Item 1')),
                      Center(child: Text('Item 2')),
                      Center(child: Text('Item 3')),
                  ],
              ),
            ),
          
            ),
          ]
        ),
      )

    );

  }


}