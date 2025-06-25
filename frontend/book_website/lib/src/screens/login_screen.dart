import 'package:flutter/material.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: SizedBox(
          width: 600,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(  
                  decoration: InputDecoration(  
                    border: OutlineInputBorder(),
                    hintText: 'Enter your username'
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(  
                  decoration: InputDecoration(  
                    border: OutlineInputBorder(),
                    hintText: 'Enter your password'
                  )
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                }, 
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text('Login'),
                )
              )
            ],
          ),
        )
      ),
    );
  }
}