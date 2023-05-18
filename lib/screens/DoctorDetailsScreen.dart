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
        backgroundColor: Color.fromRGBO(145, 186, 79, 1),
      ),
      body: Column(
        children: [
          SizedBox(height: 16.0),
          CircleAvatar(
            radius: 60.0,
            backgroundImage: AssetImage(doctor.imagePath), // Replace with the actual image path
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
          SizedBox(height: 30.0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  spreadRadius: 5,
                  blurRadius: 10,
                  color: Colors.grey.withOpacity(0.3)
                )
              ]
            ),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.phoneNumber,
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 24,),
                    Text(
                      doctor.email,
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.phone), color: Color.fromRGBO(57, 99, 54, 1),),
                    IconButton(onPressed: () {}, icon: Icon(Icons.mail), color: Color.fromRGBO(57, 99, 54, 1),)
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 30.0),
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