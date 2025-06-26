import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _loading = false;
  bool _isRegistering = false;

  void _login() async {
    setState(() => _loading = true);

    final success = await context.read<AuthNotifier>().login(
      _usernameController.text,
      _passwordController.text,
    );

    setState(() => _loading = false);

    if (success) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid credentials")),
      );
    }
  }

  void _register() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    setState(() => _loading = true);

    // uncomment below once registration is implemented on the backend

    // final success = await context.read<AuthNotifier>().register(
    //   _usernameController.text,
    //   _passwordController.text,
    // );

    // setState(() => _loading = false);

    // if (success) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text("User created successfully")),
    //   );
    //   setState(() => _isRegistering = false); // switch back to login
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text("Registration failed")),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Authentication")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            width: 320,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => setState(() => _isRegistering = false),
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontWeight: _isRegistering ? FontWeight.normal : FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => setState(() => _isRegistering = true),
                      child: Text(
                        "Register",
                        style: TextStyle(
                          fontWeight: _isRegistering ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: "Username"),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: "Password"),
                  obscureText: true,
                ),
                if (_isRegistering)
                  TextField(
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(labelText: "Confirm Password"),
                    obscureText: true,
                  ),
                const SizedBox(height: 16),
                _loading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _isRegistering ? _register : _login,
                        child: Text(_isRegistering ? "Register" : "Sign In"),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Login')),
//       body: Center(
//         child: SizedBox(
//           width: 600,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(  
//                   decoration: InputDecoration(  
//                     border: OutlineInputBorder(),
//                     hintText: 'Enter your username'
//                   )
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(  
//                   decoration: InputDecoration(  
//                     border: OutlineInputBorder(),
//                     hintText: 'Enter your password'
//                   )
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 }, 
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: const Text('Login'),
//                 )
//               )
//             ],
//           ),
//         )
//       ),
//     );
//   }
// }