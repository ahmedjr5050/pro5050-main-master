import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pro2/Doctor/auth/signin.dart';
import 'package:pro2/Doctor/home/apporitement.dart';
import 'package:pro2/Doctor/home/disease.dart';
import 'package:pro2/Doctor/home/doctors.dart';

class HomeAdmin extends StatelessWidget {
  const HomeAdmin({super.key});

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginDoctor()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign out failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Admin',
          style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _signOut(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DoctorUpdate()),
                  );
                },
                contentPadding: const EdgeInsets.all(10),
                leading: const Icon(Icons.info),
                shape: const RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.green,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  size: 30,
                ),
                title: const Text(
                  'Docotor Update',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DiseaseUpdate()));
                },
                contentPadding: const EdgeInsets.all(10),
                leading: const Icon(Icons.info),
                shape: const RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.green,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  size: 30,
                ),
                title: const Text(
                  'Disease Update',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Apporitement()));
                },
                contentPadding: const EdgeInsets.all(10),
                leading: const Icon(Icons.info),
                shape: const RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.green,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  size: 30,
                ),
                title: const Text(
                  'Appointments',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
