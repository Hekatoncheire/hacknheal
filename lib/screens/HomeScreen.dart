import 'package:flutter/material.dart';
import 'package:hack_heal/screens/ChatScreen.dart';
import 'package:hack_heal/screens/DoctorsPage.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  int _selectedIndex = -1;

  List<String> timePoints = [
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
    '6:00 PM',
    '7:00 PM',
    '8:00 PM',
  ];
  final List<Examination> examinations = [
    Examination(
      title: 'Blood Test',
      date: 'May 10, 2023',
      result: 'Normal',
    ),
    Examination(
      title: 'X-Ray',
      date: 'May 5, 2023',
      result: 'No abnormalities found',
    ),
    Examination(
      title: 'MRI Scan',
      date: 'April 28, 2023',
      result: 'Minor ligament tear',
    ),
    // Add more examinations as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HealthApp'),
        backgroundColor: Colors.redAccent,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Consultancy'),
              onTap: () {
                // TODO: Handle navigation to consultancy page
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage()));
              },
            ),
            ListTile(
              title: Text('Doctors'),
              onTap: () {
                // TODO: handle navigation to the doctors page
                Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorListPage()));
              },
            )
            // Add more drawer items as needed
          ],
        ),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30.0, left: 16, right: 16),
                child: Text(
                  'Appointments',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TableCalendar(
                  calendarFormat: _calendarFormat,
                  focusedDay: _focusedDay,
                  firstDay: DateTime(2023),
                  lastDay: DateTime(2024),
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (selectedDay.isBefore(DateTime.now().subtract(Duration(days: 1)))) {
                      // Disable selection for days before the current day
                      return;
                    }

                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  calendarStyle: CalendarStyle(
                    // other style properties
                    selectedDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.redAccent, // Set your desired color here
                    ),
                  ),
                ),
              ),
              // Add appointment details section
              SizedBox(height: 20),
              // Time points list
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: timePoints.length,
                  itemBuilder: (context, index) {
                    final timePoint = timePoints[index];
                    final isSelected = index == _selectedIndex;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      child: Container(
                        width: 100,
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.redAccent : Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            timePoint,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              // Button for appointment detail
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to appointment detail page
                  },
                  child: Text('Book Appointment'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Medical History',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: examinations.length,
                  itemBuilder: (context, index) {
                    final examination = examinations[index];

                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0, 2),
                            blurRadius: 4,
                          )
                        ]
                      ),
                      child: Center(
                        child: ListTile(
                          subtitle: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(examination.title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),),
                                  SizedBox(height: 8,),
                                  Text('Date: ${examination.date}'),
                                  SizedBox(height: 8),
                                  Text('Result: ${examination.result}'),
                                ],
                              ),
                              IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                          ),
                          // Add more customization to the list tile as needed
                        ),
                      ),
                    );
                  },
                ),
              ),
              Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('View all history'),
                    style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                  )
              )
            ],
          ),
        ],
      ),
    );
  }
}

class Examination {
  final String title;
  final String date;
  final String result;

  Examination({required this.title, required this.date, required this.result});
}
