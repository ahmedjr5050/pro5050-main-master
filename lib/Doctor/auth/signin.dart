import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pro2/Doctor/home/admin.dart';
import 'package:pro2/other_widgets/snakbar.dart';

class LoginDoctor extends StatefulWidget {
  @override
  _LoginDoctorState createState() => _LoginDoctorState();
}

class _LoginDoctorState extends State<LoginDoctor> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String? emailError;
  String? passwordError;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.asset('assets/background.png'),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 60.0, bottom: 20.0, left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 50.0),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back,',
                      style: TextStyle(fontSize: 30.0),
                    ),
                    Text(
                      'please login',
                      style: TextStyle(fontSize: 30.0),
                    ),
                    Text(
                      'to your account',
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ],
                ),
                Column(
                  children: [
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        setState(() {
                          emailError = _validateEmail(value);
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Email',
                        labelText: 'Email',
                        errorText: emailError,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          passwordError = _validatePassword(value);
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Password',
                        labelText: 'Password',
                        errorText: passwordError,
                      ),
                    ),
                  ],
                ),
                MaterialButton(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  color: const Color(0xff447def),
                  onPressed: isLoading
                      ? null
                      : () async {
                          if (_isValidForm()) {
                            setState(() {
                              isLoading = true;
                            });
                            String email = _emailController.text.trim();
                            String password = _passwordController.text.trim();
                            try {
                              var adminSnapshot = await _firestore
                                  .collection("admin")
                                  .doc("AdminLogin")
                                  .get();

                              var adminData = adminSnapshot.data();
                              if (adminData != null &&
                                  adminData['Email'] == email &&
                                  adminData['password'] == password) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomeAdmin()),
                                  (route) => false,
                                );
                              } else {
                                snakebarMasseage(
                                    context, 'Invalid email or password');
                              }
                            } catch (e) {
                              snakebarMasseage(context, e.toString());
                            } finally {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }
                        },
                  child: isLoading
                      ? CircularProgressIndicator()
                      : const Text(
                          'Login',
                          style: TextStyle(fontSize: 25.0, color: Colors.white),
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        height: 1.0,
                        width: 60.0,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String? _validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  bool _isValidForm() {
    setState(() {
      emailError = _validateEmail(_emailController.text.trim());
      passwordError = _validatePassword(_passwordController.text.trim());
    });
    return emailError == null && passwordError == null;
  }
}
