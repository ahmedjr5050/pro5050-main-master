import 'package:flutter/material.dart';

class DocotrProfile extends StatelessWidget {
  const DocotrProfile({super.key, required this.doctorName});
  final String doctorName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(doctorName),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text(doctorName),
      ),
    );
  }
}
