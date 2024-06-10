import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro2/chatboot/chatbot.dart';
import 'package:pro2/other_widgets/custom_tile.dart';
import 'package:pro2/patients/presention/doctor_avaliable/diseasesdetails.dart';
import 'package:pro2/patients/presention/onboard/welcome_screen.dart';

class PatienPanel extends StatefulWidget {
  const PatienPanel({super.key});

  @override
  State<PatienPanel> createState() => _PatienPanelState();
}

List<QueryDocumentSnapshot> diseaseList = [];

class _PatienPanelState extends State<PatienPanel> {
  Future getDiseaseInfo() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("Diseases").get();
    return qn.docs;
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
    );
  }

  void _startChat() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChatPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: const Text("Patient's Panel"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _signOut,
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: width,
              margin: EdgeInsets.fromLTRB(0, height * 0.03, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[],
              ),
            ),
            Container(
              height: height * 0.1,
              width: width * 0.45,
              margin: EdgeInsets.fromLTRB(width * 0.21, height * 0.18, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Patient's",
                    style: GoogleFonts.abel(
                        fontSize: height * 0.04, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Panel',
                    style: TextStyle(fontSize: height * 0.025),
                  )
                ],
              ),
            ),
            FutureBuilder(
              future: getDiseaseInfo(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ),
                  );
                } else {
                  return Container(
                    margin: EdgeInsets.fromLTRB(0, height * 0.32, 0, 0),
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.transparent,
                      ),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return CustomTile(
                          delBtn: false,
                          snapshot: snapshot.data[index],
                          onTap: (snapshot) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DiseaseDetails(
                                  diseaseName: snapshot['diseaseName'] ?? '',
                                  doctors:
                                      (snapshot['doctors'] as List<dynamic>)
                                          .map((doctor) {
                                    return {
                                      'id': snapshot.id,
                                      'DoctorName':
                                          doctor['DocotorName'] as String,
                                      'Speciality':
                                          doctor['Speciality'] as String,
                                      'address': doctor['address'] as String,
                                      'phone': doctor['phone'] as String,
                                      'about': doctor['about'] as String,
                                      'email': doctor['email'] as String
                                    };
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                }
              },
            ),
            Positioned(
                top: height * 0.13,
                left: width - 130,
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Colors.black.withOpacity(0.5),
                        Colors.black.withOpacity(1.0),
                        Colors.black.withOpacity(1.0),
                        Colors.black.withOpacity(0.5),
                      ],
                    ).createShader(
                        Rect.fromLTRB(0, 0, rect.width, rect.height));
                  },
                  blendMode: BlendMode.dstIn,
                  child: Image(
                      height: height * 0.15,
                      image: const AssetImage('assets/bigPat.png')),
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startChat,
        child: const Icon(Icons.chat),
      ),
    );
  }
}