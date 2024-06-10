// ignore_for_file: use_build_context_synchronously, avoid_print, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro2/other_widgets/backbtn.dart';
import 'package:pro2/other_widgets/snakbar.dart';

final controllerDisName = TextEditingController();
final controllerMedName = TextEditingController();
final controllerMedDose = TextEditingController();
final controllerDesc = TextEditingController();

class AddNewDoctor extends StatefulWidget {
  const AddNewDoctor({super.key});

  @override
  _AddNewDoctorState createState() => _AddNewDoctorState();
}

class _AddNewDoctorState extends State<AddNewDoctor> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final disNameTF = TextField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: controllerDisName,
      onSubmitted: (_) => FocusScope.of(context).nextFocus(),
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image(
                image: const AssetImage('assets/injection.png'),
                height: height * 0.04),
          ),
          labelText: 'Docotr Name',
          filled: true,
          fillColor: Colors.black.withOpacity(0.05),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final medNameTF = TextField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: controllerMedName,
      onSubmitted: (_) => FocusScope.of(context).nextFocus(),
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image(
              image: const AssetImage('assets/tablets.png'),
              height: height * 0.04,
            ),
          ),
          labelText: 'Doctor Speciality',
          filled: true,
          fillColor: Colors.black.withOpacity(0.05),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final medDescTF = TextField(
      keyboardType: TextInputType.multiline,
      autofocus: false,
      controller: controllerDesc,
      maxLines: null,
      decoration: InputDecoration(
          prefixIcon: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image(
              image: const AssetImage('assets/steth.png'),
              height: height * 0.04,
            ),
          ),
          labelText: 'Description',
          filled: true,
          fillColor: Colors.black.withOpacity(0.05),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    controllerClear() {
      controllerDisName.clear();
      controllerMedName.clear();
      controllerMedDose.clear();
      controllerDesc.clear();
    }

    Future<void> adddoctor(
        String doctorname, String doctorSpeciality, String about) async {
      if (doctorname.isNotEmpty) {
        try {
          await FirebaseFirestore.instance.collection("Doctor").add({
            'DocotorName': doctorname,
            'Speciality': doctorSpeciality,
            'about': about,
          });
          snakebarMasseage(context, 'Added Successfully');
          controllerClear();
        } catch (e) {
          print('Error adding disease: $e');
        }
      } else {}
    }

    final addBtn = SizedBox(
        width: double.infinity,
        height: 50,
        child: MaterialButton(
          onPressed: () {
            adddoctor(controllerDisName.text, controllerMedName.text,
                controllerDesc.text);
            setState(() {});
          },
          color: Colors.white,
          shape: const StadiumBorder(),
          child: const Text(
            'Add',
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
          ),
        ));

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: width,
              margin: EdgeInsets.fromLTRB(width * 0.025, 0, width * 0.025, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  BackBtn(),
                  SizedBox(height: height * 0.05),
                  Row(
                    children: <Widget>[
                      Text(
                        'Adding',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: height * 0.04),
                      ),
                      SizedBox(width: height * 0.015),
                      Text('Disease',
                          style: GoogleFonts.abel(fontSize: height * 0.04))
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    'Enter the Following Information',
                    style: GoogleFonts.abel(fontSize: height * 0.025),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  disNameTF,
                  SizedBox(
                    height: height * 0.015,
                  ),
                  medNameTF,
                  SizedBox(
                    height: height * 0.015,
                  ),
                  // medTimeTF,
                  SizedBox(
                    height: height * 0.015,
                  ),
                  medDescTF,
                  SizedBox(
                    height: height * 0.02,
                  ),
                  addBtn,
                  SizedBox(
                    height: height * 0.01,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
