import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/auth_user.dart';
import '../viewmodels/auth_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController(text: 'eve.holt@reqres.in');
  final TextEditingController _passwordController = TextEditingController(text: 'pistol');

  @override
  Widget build(BuildContext context) {
    // final authVM = Provider.of<LoginPageViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            // authVM.isLoading
            //     ? const CircularProgressIndicator():
          ElevatedButton(
              onPressed: () async {
                // final email = _emailController.text.trim();
                // final password = _passwordController.text.trim();
                //
                // final success = await authVM.login(email, password);
                //
                // if (success) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(content: Text('Login successful!')),
                //   );
                //   // Navigate to home page if needed
                // } else {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(content: Text(authVM.errorMessage ?? 'Login failed')),
                //   );
                // }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
