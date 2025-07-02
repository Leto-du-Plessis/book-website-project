import 'package:flutter/material.dart';

class CarouselWindow extends StatelessWidget {
  const CarouselWindow({super.key});

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Popular Books')),
          CarouselWidget(),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Fantasy Books')),
          CarouselWidget(),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Sci-fi Books')),
          CarouselWidget() 
        ],
      )
    );  
  }
}      
      
       
class CarouselWidget extends StatelessWidget {
  const CarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {
      return Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [SizedBox(
          height: 200,
            child: Container(
              padding:EdgeInsetsGeometry.fromLTRB(20,10,20,20),
              child: CarouselView(
                controller: CarouselController(),
                scrollDirection: Axis.horizontal,
                  backgroundColor: Colors.blueAccent,
                  itemExtent: 200,
                  children: List<Widget>.generate(20, (int index){                    
                    return Container(
                      alignment: Alignment.center, 
                      child: Text( 'Item $index')
                    );
                  }
                  )
              ),
            ),
            ),
          ]
        ),
      ); 
  } 
}  
