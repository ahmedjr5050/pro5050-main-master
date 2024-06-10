// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro2/other_widgets/custom_tile.dart';
import 'package:pro2/patients/presention/onboard/welcome_screen.dart';

class DiseaseUpdate extends StatefulWidget {
  const DiseaseUpdate({super.key});

  @override
  State<DiseaseUpdate> createState() => _DiseaseUpdateState();
}

List<QueryDocumentSnapshot> diseaseList = [];

class _DiseaseUpdateState extends State<DiseaseUpdate> {
  TextEditingController _diseaseController = TextEditingController();

  Future<void> _addDisease(String disease) async {
    if (disease.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection("Diseases").add({
          'diseaseName': disease,
        });

        _diseaseController.clear();
      } catch (e) {
        print('Error adding disease: $e');
      }
    } else {}
  }

  Future<void> _deleteDisease(String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection("Diseases")
          .doc(docId)
          .delete();
    } catch (e) {
      print('Error deleting disease: $e');
    }
  }

  Future getDiseaseInfo() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("Diseases").get();

    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: width,
              margin: EdgeInsets.fromLTRB(0, height * 0.03, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                      onTap: () => Navigator.of(context).pop(true),
                      child: Icon(
                        Icons.arrow_back,
                        size: height * 0.04,
                      )),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  SizedBox(
                    width: width * 0.7,
                    height: height * 0.052,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                          labelText: 'Disease/Medicine',
                          prefixIcon: Icon(
                            Icons.search,
                            size: height * 0.03,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WelcomeScreen())),
                    child: Hero(
                      tag: 'patPic',
                      child: CircleAvatar(
                          radius: height * 0.025,
                          backgroundColor: Colors.black.withOpacity(0.2),
                          backgroundImage: const NetworkImage(
                              scale: 1,
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxOX4mkcW8pH9FbpI9rTBkokiMxSY2GJ3eyw&usqp=CAU')),
                    ),
                  ),
                ],
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
                    "Doctor'S",
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
                          delBtn: true,
                          snapshot: snapshot.data[index],
                          onTap: (snapshot) {
                            _deleteDisease(snapshot.id);
                            setState(() {});
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
                      image: const AssetImage('assets/doctor.png')),
                )),
            Positioned(
                top: height * 0.13,
                right: width - 140,
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
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () {
                          showPlatformDialog(
                            context: context,
                            builder: (_) => BasicDialogAlert(
                              title: const Text('Add Disease'),
                              content: TextFormField(
                                controller: _diseaseController,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Disease Name',
                                ),
                              ),
                              actions: <Widget>[
                  
                                BasicDialogAction(
                                  onPressed: () {
                                    String disease = _diseaseController.text;
                                    _addDisease(disease);
                                    Navigator.pop(context);
                                  },
                                  title: const Text('Add'),
                                ),
                              ],
                            ),
                          );
                        },
                        child: const Text(
                          'Add Disease',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        )))),
          ],
        ),
      ),
    );
  }
}
