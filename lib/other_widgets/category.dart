import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pro2/Doctor/auth/signin.dart';
import 'package:pro2/patients/presention/signin/patienlogin.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Future<bool> onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: const Text(
                "Exit Application",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: const Text("Are You Sure?"),
              actions: <Widget>[
                MaterialButton(
                  shape: const StadiumBorder(),
                  color: Colors.white,
                  child: const Text(
                    "No",
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                MaterialButton(
                  shape: const StadiumBorder(),
                  color: Colors.white,
                  child: const Text(
                    "Yes",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    exit(0);
                  },
                ),
              ],
            ),
          )) ??
          false;
    }

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: height * 0.065,
              ),
              Container(
                margin: EdgeInsets.only(left: width * 0.05),
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Category',
                      style: TextStyle(
                          color: Colors.black, fontSize: height * 0.04),
                    ),
                    MaterialButton(
                      shape: const CircleBorder(),
                      onPressed: () => Navigator.pushNamed(context, '/AboutUs'),
                      child: Icon(
                        Icons.info,
                        size: height * 0.04,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: height * 0.09),
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.2),
                      radius: height * 0.075,
                      child: Image(
                        image: const AssetImage("assets/doctor.png"),
                        height: height * 0.2,
                      ),
                    ),
                    patDocBtn('Doctor', context, () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginDoctor()));
                    }),
                    SizedBox(
                      height: height * 0.1,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.2),
                      radius: height * 0.075,
                      child: Image(
                        image: const AssetImage("assets/patient.png"),
                        height: height * 0.2,
                      ),
                    ),
                    patDocBtn('Patient', context, () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PatientLogin()));
                    }),
                    SizedBox(
                      height: height * 0.13,
                    ),
                    const Column(
                      children: <Widget>[
                        Text(
                          'Version',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'V 0.1',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget patDocBtn(String categoryText, context, void Function() onpressed) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.5,
      child: ElevatedButton(
        onPressed: () {
          onpressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: const StadiumBorder(),
        ),
        child: Text(
          "I am " + categoryText,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
