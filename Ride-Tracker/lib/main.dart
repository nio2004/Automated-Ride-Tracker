import "package:automated_ride_tracker/fetch_data.dart";
import 'package:automated_ride_tracker/homepages/admin.dart';
import 'package:automated_ride_tracker/homepages/driver.dart';
import 'package:automated_ride_tracker/homepages/passenger.dart';
import 'package:automated_ride_tracker/loginpage.dart';
import 'package:automated_ride_tracker/maps.dart';
import 'package:automated_ride_tracker/navbar/viewhistory.dart';
import "package:flutter/material.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_map/flutter_map.dart';
import 'registerpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:automated_ride_tracker/navbar/pickup_time.dart';
import 'package:automated_ride_tracker/navbar/show_request.dart';
import 'package:automated_ride_tracker/homepages/homepage.dart';
//void main() => runApp(MyApp());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue[900],
      ),
      home: Passenger(),
      routes: {
        'login': (context) => LoginPage(),
        'register': (context) => Register(),
        'home': (context) => HomePage(),
        'admin': (context) => Admin(),
        'pickup': (context) => Pickup(),
        'driver': (context) => Driver(),
        'passenger': (context) => Passenger(),
        'history': (context) => historydisplay(),
      },
    );
  }
}
