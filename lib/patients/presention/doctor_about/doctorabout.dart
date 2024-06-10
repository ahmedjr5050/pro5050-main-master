import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DoctorAbout extends StatelessWidget {
  final Map<String, dynamic> doctorData;

  DoctorAbout({
    Key? key,
    required this.doctorData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextEditingController phone = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctor's Information"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(width * 0.015),
              width: width,
              height: height * 0.7,
              margin: EdgeInsets.only(
                  left: width * 0.05, top: height * 0.05, right: width * 0.05),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      doctorData['DoctorName'] ?? 'Unknown',
                      style: TextStyle(
                          fontSize: height * 0.04, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.stars,
                          size: height * 0.03,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Text(
                          doctorData['address'] ?? 'Unknown',
                          style: GoogleFonts.abel(fontSize: height * 0.025),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.phone,
                            size: height * 0.03, color: Colors.blue),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Text(
                          doctorData['phone'] ?? 'Unknown',
                          style: GoogleFonts.abel(fontSize: height * 0.025),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.email,
                            size: height * 0.03, color: Colors.green),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Text(
                          doctorData['email'] ?? 'Unknown',
                          style: GoogleFonts.abel(fontSize: height * 0.025),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'About: ',
                          style: TextStyle(
                              fontSize: height * 0.025,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.black38)),
                          padding: const EdgeInsets.all(5),
                          height: height * 0.3,
                          width: width,
                          child: ListView(
                            children: <Widget>[
                              Text(
                                doctorData['about'] ?? 'Unknown',
                                style:
                                    GoogleFonts.abel(fontSize: height * 0.025),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(width * 0.5, height * 0.05),
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                showPlatformDialog(
                                  context: context,
                                  builder: (context) => BasicDialogAlert(
                                    title:
                                        const Text("Enter Your Phone Number"),
                                    content: Form(
                                      key: _formKey,
                                      child: TextFormField(
                                        controller: phone,
                                        scrollController: ScrollController(
                                          keepScrollOffset: true,
                                          debugLabel: height.toString(),
                                          initialScrollOffset: 0,
                                        ),
                                        keyboardType: TextInputType.phone,
                                        decoration: const InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: 'Phone',
                                          hintText: '+20 11 123 456 789',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your phone number';
                                          }
                                          // Regular expression to validate phone numbers
                                          final regex =
                                              RegExp(r'^\+?[0-9]{10,15}$');
                                          if (!regex.hasMatch(value)) {
                                            return 'Enter a valid phone number';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    actions: <Widget>[
                                      BasicDialogAction(
                                        title: const Text("Send"),
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            String phoneNumber = phone.text;

                                            // Access Firestore instance
                                            CollectionReference
                                                diseasesCollection =
                                                FirebaseFirestore.instance
                                                    .collection("Diseases");

                                            // Update the disease document in the Diseases collection
                                            await diseasesCollection
                                                .doc(doctorData[
                                                    'id']) // Use the specific disease document ID
                                                .update({
                                              'Appointments':
                                                  FieldValue.arrayUnion(
                                                      [phoneNumber]),
                                            });

                                            // Show success toast
                                            Fluttertoast.showToast(
                                              msg:
                                                  "Appointment added successfully!",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.green,
                                              textColor: Colors.white,
                                              fontSize: 16.0,
                                            );

                                            Navigator.pop(context);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Text(
                                'Book Now',
                                style: TextStyle(
                                    fontSize: height * 0.025,
                                    fontWeight: FontWeight.bold),
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
