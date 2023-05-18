import 'package:flutter/material.dart';
import 'package:hack_heal/screens/HomeScreen.dart';

class AuthPage extends StatefulWidget {
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // Dispose the text editing controllers when the widget is disposed
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signIn() {
    String email = emailController.text;
    String password = passwordController.text;

    // TODO: Implement sign-in logic using the email and password

    // Clear the text fields after sign-in
    emailController.clear();
    passwordController.clear();
  }

  void signUp() {
    String email = emailController.text;
    String password = passwordController.text;

    // TODO: Implement sign-up logic using the email and password

    // Clear the text fields after sign-up
    emailController.clear();
    passwordController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Welcome to Medik',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Handle sign in button click
                signIn();
                Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(145, 186, 79, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.all(15.0),
              ),
              child: Text(
                'Sign In',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                // Handle sign up button click
                signUp();
                Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
              },
              child: Text(
                'Create an Account',
                style: TextStyle(fontSize: 16.0),
              ),
              style: TextButton.styleFrom(
                primary: Color.fromRGBO(57, 99, 54, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
