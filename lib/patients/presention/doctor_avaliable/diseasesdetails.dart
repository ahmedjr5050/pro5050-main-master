import 'package:flutter/material.dart';
import 'package:pro2/patients/presention/doctor_about/doctorabout.dart';

class DiseaseDetails extends StatelessWidget {
  final String diseaseName;
  final List<Map<String, String>> doctors;

  DiseaseDetails({
    required this.diseaseName,
    required this.doctors,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(diseaseName),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Specialist Doctors:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...doctors.map((doctor) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorAbout(doctorData: doctor),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(
                      doctor['DoctorName']!,
                      style: const TextStyle(fontSize: 16),
                    ),
                    subtitle: Text(
                      doctor['Speciality']!,
                      style: const TextStyle(fontSize: 14),
                    ),
                    leading: const Icon(Icons.person),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
