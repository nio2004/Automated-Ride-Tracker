import 'package:automated_ride_tracker/homepages/passenger.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
//import 'package:tracker/loginpage.dart';
//import 'package:tracker/registerpage.dart';

import "package:automated_ride_tracker/fetch_data.dart";
import 'package:automated_ride_tracker/loginpage.dart';
import 'package:automated_ride_tracker/maps.dart';
import "package:flutter/material.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_map/flutter_map.dart';
//import 'registerpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:automated_ride_tracker/navbar/pickup_time.dart';
import 'package:automated_ride_tracker/navbar/show_request.dart';
//void main() => runApp(MyApp());

// void main() => runApp(MaterialApp(
//       home: BottomNavBar(),
//       debugShowCheckedModeBanner: false,
//       initialRoute: 'home',
//       routes: {
//         'login': (context) => LoginPage(),
//         'register': (context) => Register(),
//         'home': (context) => BottomNavBar()
//       },
//     ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Passenger(),
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: const Text("Welcome to Ride Tracker"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              //find a button
            },
            child: const Text(
              "Find a way",
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              //find a button
            },
            child: const Text(
              "History",
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              //find a button
            },
            child: const Text("Profile"),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              //find a button
            },
            child: const Text("Pickup Time"),
          ),
          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(
            height: 32,
          ),
          ElevatedButton(
            onPressed: () {
              //contact us button
            },
            child: const Text("Contact Us"),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Handle "About Us" button press
            },
            child: const Text('About Us'),
          ),
        ],
      )),

      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 60.0,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.favorite, size: 30),
          Icon(Icons.compare_arrows, size: 30),
          Icon(Icons.perm_identity, size: 30),
          Icon(Icons.settings, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      // body: Container(
      //   color: Colors.blueAccent,
      //   child: Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         Text(_page.toString(), textScaleFactor: 10.0),
      //         ElevatedButton(
      //           child: Text('Go To Page of index 1'),
      //           onPressed: () {
      //             final CurvedNavigationBarState? navBarState =
      //                 _bottomNavigationKey.currentState;
      //             navBarState?.setPage(1);
      //           },
      //         )
      //       ],
      //     ),
      //   ),
      // )
    );
  }
}
