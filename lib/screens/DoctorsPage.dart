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
      contactInfo: 'Phone: 123-456-7890\nEmail: john.doe@example.com',
    ),
    Doctor(
      name: 'Dr. Jane Smith',
      specialization: 'Dermatologist',
      rating: 4.8,
      hospital: 'XYZ Hospital',
      contactInfo: 'Phone: 987-654-3210\nEmail: jane.smith@example.com',
    ),
    // Add more doctors as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctors List'),
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