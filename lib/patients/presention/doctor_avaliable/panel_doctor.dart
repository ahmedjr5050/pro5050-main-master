import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pro2/patients/presention/doctor_about/doctorabout.dart';

class DoctorPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference doctors =
        FirebaseFirestore.instance.collection('Doctor');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: Colors.green,
        title: const Text(
          "Doctor's List",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: doctors.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              data['id'] = document.id;
              print(data);
              return buildDoctorListItem(data, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DoctorAbout(
                      doctorData: data,
                    ),
                  ),
                );
              });
            }).toList(),
          );
        },
      ),
    );
  }

  Widget buildDoctorListItem(
      Map<String, dynamic> doctorData, void Function()? onTap) {
    {
      return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          onTap: () {
            onTap!();
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.grey.shade500, width: 2),
          ),
          leading: const Icon(Icons.person),
          title: Text(
            doctorData['DocotorName'] ?? 'Unknown',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            doctorData['Speciality'] ?? 'Unknown',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: const Icon(Icons.arrow_forward),
        ),
      );
    }
  }
}
