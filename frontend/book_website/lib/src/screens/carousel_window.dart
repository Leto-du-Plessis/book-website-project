import 'package:flutter/material.dart';
import '../widgets/custom_carousel.dart';


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
          CustomCarousel(),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Fantasy Books')),
          CustomCarousel(),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Sci-fi Books')),
          CustomCarousel() 
        ],
      )
    );  
  }
}