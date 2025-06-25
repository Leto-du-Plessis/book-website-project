import 'package:flutter/material.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(  
                decoration: InputDecoration(  
                  border: OutlineInputBorder(),
                  hintText: 'Enter your username'
                )
              ),
              TextFormField(  
                decoration: InputDecoration(  
                  border: OutlineInputBorder(),
                  hintText: 'Enter your password'
                )
              ),
            ],
          ),
        )
      ),
    );
  }
}