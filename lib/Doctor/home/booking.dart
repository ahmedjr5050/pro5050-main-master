import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Booking extends StatelessWidget {
  final Map<String, dynamic> doctorData;

  const Booking({
    Key? key,
    required this.doctorData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appointments = doctorData['Appointments'];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          'Booking',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: appointments is List
            ? ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(color: Colors.green),
                      ),
                      title: Text(
                        'Appointments ${index + 1}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Text(
                        appointments[index].toString(),
                        style: const TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  );
                },
              )
            : const Text('No appointments'),
      ),
    );
  }
}
