import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pro2/patients/presention/home_page/patien_panel.dart';
import 'package:pro2/patients/presention/signin/patienlogin.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PatienPanel()),
        );
      }
    } catch (error) {
      Fluttertoast.showToast(msg: "Error signing in with Google: $error");
    }
  }

  Future<void> signUpWithEmailAndPassword(BuildContext context) async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String fullName = _fullNameController.text.trim();

    if (email.isEmpty || password.isEmpty || fullName.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill in all fields");
      return;
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      Fluttertoast.showToast(msg: "Please enter a valid email address");
      return;
    }

    if (password.length < 6) {
      Fluttertoast.showToast(
          msg: "Password should be at least 6 characters long");
      return;
    }

    if (fullName.length < 3) {
      Fluttertoast.showToast(
          msg: "Full Name should be at least 3 characters long");
      return;
    }

    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        // Update the user's display name
        await userCredential.user?.updateDisplayName(fullName);

        Fluttertoast.showToast(msg: "Account created successfully");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  PatienPanel()),
        );
      }
    } catch (error) {
      Fluttertoast.showToast(
          msg: "Error signing up with email and password: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Create Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Enter your Email address, Name, and Password for sign Up',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Handle forgot password
                    },
                    child: const Text('Forget Password?'),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    signUpWithEmailAndPassword(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    'SIGN UP',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PatientLogin()),
                        );
                      },
                      child: const Text('Sign in.'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    signInWithGoogle(context);
                  },
                  icon: const Icon(Icons.email, color: Colors.white),
                  label: const Text(
                    'CONNECT WITH GOOGLE',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
