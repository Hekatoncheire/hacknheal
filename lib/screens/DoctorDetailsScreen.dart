import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


import '../models/DoctorModel.dart';

class DoctorDetailPage extends StatelessWidget {
  final Doctor doctor;

  DoctorDetailPage({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Details'),
      ),
      body: Column(
        children: [
          SizedBox(height: 16.0),
          CircleAvatar(
            radius: 60.0,
            backgroundImage: AssetImage('assets/images/doctor_avatar.jpg'), // Replace with the actual image path
          ),
          SizedBox(height: 16.0),
          Text(
            doctor.name,
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            doctor.specialization,
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.yellow),
              SizedBox(width: 4.0),
              Text(
                doctor.rating.toString(),
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Text(
            'Hospital: ${doctor.hospital}',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 16.0),
          Text(
            'Contact Info:',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            doctor.contactInfo,
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 16.0),
          Text(
            'Reviews:',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          CarouselSlider(
            items: [
              ReviewCard(review: 'Great doctor! Highly recommended.'),
              ReviewCard(review: 'Very knowledgeable and caring.'),
              // Add more reviews as needed
            ],
            options: CarouselOptions(
              height: 120.0,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              pauseAutoPlayOnTouch: true,
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final String review;

  ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(review),
      ),
    );
  }
}