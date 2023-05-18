import 'package:flutter/material.dart';
import 'package:hack_heal/screens/DoctorDetailsScreen.dart';

import '../models/DoctorModel.dart';

class DoctorListPage extends StatelessWidget {
  final List<Doctor> doctors = [
    Doctor(
        name: 'Dr. John Doe',
        specialization: 'Cardiologist',
        rating: 4.5,
        hospital: 'ABC Hospital',
        phoneNumber: '123-456-7890',
        email: 'john.doe@example.com',
        imagePath: 'lib/assets/images/john_doe_medik.jpeg'),
    Doctor(
        name: 'Dr. Jane Smith',
        specialization: 'Dermatologist',
        rating: 4.8,
        hospital: 'XYZ Hospital',
        phoneNumber: '987-654-3210',
        email: 'jane.smith@example.com',
        imagePath: 'lib/assets/images/jane_smith_medik.jpeg'),
    // Add more doctors as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctors List'),
        backgroundColor: Colors.redAccent,
      ),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];

          return ListTile(
            title: Text(doctor.name),
            subtitle: Text(doctor.specialization),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorDetailPage(doctor: doctor),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
