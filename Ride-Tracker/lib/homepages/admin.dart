import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:automated_ride_tracker/loginpage.dart';
import 'package:automated_ride_tracker/maps.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {

  final user = FirebaseAuth.instance.currentUser!.email;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("Passenger"),
    //     actions: [
    //       IconButton(
    //         onPressed: () {
    //           logout(context);
    //         },
    //         icon: Icon(
    //           Icons.logout,
    //         ),
    //       )
    //     ],
    //   ),
    // );

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                user!.substring(0,user!.indexOf('@')),
                style: TextStyle(color: Colors.black),
              ),
              accountEmail: Text(
                '$user',
                style: TextStyle(color: Colors.black),
              ),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                    child: Image.network(
                  'https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_1280.png',
                  //'https://e1.pxfuel.com/desktop-wallpaper/903/679/desktop-wallpaper-97-aesthetic-best-profile-pic-for-instagram-for-boy-instagram-dp-boys.jpg',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                )),
              ),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://img.freepik.com/free-vector/blue-curve-background_53876-113112.jpg?w=900&t=st=1685791223~exp=1685791823~hmac=6a7d01c79dfa4dc1381c3a29e9f6ed8f340fbe13a5d06a2a1b049d3bf475ed0e'),
                      fit: BoxFit.fill)),
            ),
            ListTile(
              leading: Icon(Icons.directions_car),
              title: Text('Find a way'),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('History'),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.queue),
              title: Text('Requests'),
              onTap: () => null,
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.schedule),
              title: Text('Set Location'),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () => null,
            ),
            Divider(
              height: 20,
            ),
            ListTile(
              leading: Icon(Icons.contact_support),
              title: Text('Contact Us'),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About Us'),
              onTap: () => null,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: const Text("Ride Tracker"),
      ),
      // body: Center(
      //     child: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     ElevatedButton(
      //       onPressed: () {
      //         //find a button
      //       },
      //       child: const Text(
      //         "Find a way",
      //         style: TextStyle(fontSize: 20),
      //       ),
      //     ),
      //     const SizedBox(height: 16),
      //     ElevatedButton(
      //       onPressed: () {
      //         //find a button
      //       },
      //       child: const Text(
      //         "History",
      //         style: TextStyle(fontSize: 20),
      //       ),
      //     ),
      //     const SizedBox(height: 16),
      //     ElevatedButton(
      //       onPressed: () {
      //         //find a button
      //       },
      //       child: const Text("Profile"),
      //     ),
      //     const SizedBox(height: 16),
      //     ElevatedButton(
      //       onPressed: () {
      //         //find a button
      //       },
      //       child: const Text("Pickup Time"),
      //     ),
      //     const SizedBox(height: 32),
      //     const Divider(),
      //     const SizedBox(
      //       height: 32,
      //     ),
      //     ElevatedButton(
      //       onPressed: () {
      //         //contact us button
      //       },
      //       child: const Text("Contact Us"),
      //     ),
      //     const SizedBox(height: 16),
      //     ElevatedButton(
      //       onPressed: () {
      //         // Handle "About Us" button press
      //       },
      //       child: const Text('About Us'),
      //     ),
      //   ],
      // )),
      body: lmaps(),
      // body: FlutterMap(
      //     options: MapOptions(
      //       center: new LatLng(18.4522231, 73.8482393),
      //       minZoom: 10.0,
      //     ),
      //     layers: [
      //       new TileLayerOptions(
      //           urlTemplate:
      //               "https://api.mapbox.com/styles/v1/nio-supreme/clg9ctlpo001f01s6x8xxkz4m/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibmlvLXN1cHJlbWUiLCJhIjoiY2xnOTdtaXU5MDB3MjNjcWx1bHVic3o5YiJ9.cU-7_eh35LyfMN4HrUtGEw",
      //           additionalOptions: {
      //             'accessToken':
      //                 'pk.eyJ1IjoibmlvLXN1cHJlbWUiLCJhIjoiY2xnOTdtaXU5MDB3MjNjcWx1bHVic3o5YiJ9.cU-7_eh35LyfMN4HrUtGEw',
      //             'id': 'mapbox.mapbox-streets-v8'
      //           }),
      //       new MarkerLayerOptions(markers: [
      //         new Marker(
      //             width: 45.0,
      //             height: 45.0,
      //             point: new LatLng(18.4522231, 73.8482393),
      //             builder: (context) => new Container(
      //                     child: IconButton(
      //                   icon: Icon(Icons.location_on),
      //                   color: Colors.blue,
      //                   iconSize: 45.0,
      //                   onPressed: () {
      //                     print('marker 1 tapped');
      //                   },
      //                 ))),
      //         new Marker(
      //             width: 45.0,
      //             height: 45.0,
      //             point: new LatLng(18.463642, 73.867313),
      //             builder: (context) => new Container(
      //                     child: IconButton(
      //                   icon: Icon(Icons.location_on),
      //                   color: Colors.blue,
      //                   iconSize: 45.0,
      //                   onPressed: () {
      //                     print('marker 2 tapped');
      //                   },
      //                 )))
      //       ])
      //     ]),

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
        color: Colors.blueAccent,
        buttonBackgroundColor: Colors.blueAccent,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
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

  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}
