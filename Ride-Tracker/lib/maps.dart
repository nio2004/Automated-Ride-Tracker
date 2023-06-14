import 'dart:ffi';

import 'package:automated_ride_tracker/userslocation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

final MapController _mapcontrol = MapController();
class lmaps extends StatefulWidget {
  const lmaps({super.key});

  @override
  State<lmaps> createState() => _lmapsState();

  //static Widget usermark(double latitude, double longitude) {}

  //static Widget usermark(double latitude, double longitude) {}
    
  
}

class _lmapsState extends State<lmaps> {

  var latitude=0.0,longitude=0.0;
  //final MapController _mapcontrol = MapController();

  Position? _currentPosition;
  
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    //   _getAddressFromLatLng(_currentPosition!);
    // }).catchError((e) {
    //   debugPrint(e);
    });
  }

  @override
    void initState() {
      super.initState();
        getcoords();
        _getCurrentPosition();
    }
  
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
    //   appBar: AppBar(
    //   title: Text("maps"),
    // ),
    body: Stack(
      children: <Widget>[FlutterMap(
      mapController: _mapcontrol,
      options: MapOptions(
      center: new LatLng(18.4522231, 73.8482393),
      minZoom: 10.0,
      ),
        layers: [
          new TileLayerOptions(
            urlTemplate: "https://api.mapbox.com/styles/v1/nio-supreme/clg9ctlpo001f01s6x8xxkz4m/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibmlvLXN1cHJlbWUiLCJhIjoiY2xnOTdtaXU5MDB3MjNjcWx1bHVic3o5YiJ9.cU-7_eh35LyfMN4HrUtGEw",
            //urlTemplate: "https://api.mapbox.com/styles/v1/nio-supreme/clg9ctlpo001f01s6x8xxkz4m.html?title=view&access_token=pk.eyJ1IjoibmlvLXN1cHJlbWUiLCJhIjoiY2xnOTdtaXU5MDB3MjNjcWx1bHVic3o5YiJ9.cU-7_eh35LyfMN4HrUtGEw",
            additionalOptions: {
                    'accessToken': 'pk.eyJ1IjoibmlvLXN1cHJlbWUiLCJhIjoiY2xnOTdtaXU5MDB3MjNjcWx1bHVic3o5YiJ9.cU-7_eh35LyfMN4HrUtGEw',
                    'id': 'mapbox.mapbox-streets-v8'
                  }
          ),
          new MarkerLayerOptions(markers: [
            new Marker(
            width: 45.0,
            height: 45.0,
            point: new LatLng(18.4522231, 73.8482393),
            builder: (context) => new Container(
              child: IconButton(
                icon: Icon(Icons.location_on),
                color: Colors.blue,
                iconSize: 45.0,
                onPressed: () {
                  print('marker 1 tapped');
                },
          
              )
              )
           ),
           new Marker(
            width: 45.0,
            height: 45.0,
            point: new LatLng(18.463642, 73.867313),
            builder: (context) => new Container(
              child: IconButton(
                icon: Icon(Icons.location_on),
                color: Colors.blue,
                iconSize: 45.0,
                onPressed: () {
                  print('marker 2 tapped');
                },
          
              )
              )
           ),
            new Marker(
            width: 45.0,
            height: 45.0,
            point: new LatLng(latitude as double, longitude as double),
            builder: (context) => new Container(
              child: IconButton(
                icon: Icon(Icons.airport_shuttle),
                color: Colors.grey,
                iconSize: 45.0,
                onPressed: () {
                  print('marker 3 tapped');
                },
          
              )
              )
           ),
           ])
        ]
      ),
      Positioned(
            right:10,
            bottom: 10,
            height: 50,
            width: 50,
            child:  ElevatedButton(
              //padding: EdgeInsets.all(10),
              child: Icon(Icons.gps_fixed),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0),),)
              ),
              onPressed: () {
                usermark(_currentPosition?.latitude, _currentPosition?.longitude);
                print("tapped");
              },
            ), 
          ),
    ])
    )
    );
  }

  getcoords() async {
    //   DatabaseReference gref = FirebaseDatabase.instance.ref('gps-data');
    //   final snapshot1 = await gref.get();
    //   final snapshot2 = await gref.get();
    //   List list = [];
    //   final map = snapshot1.value as Map<dynamic, dynamic>;
    //    map.forEach((key, value) {

    //   list.add(key);
    // });

    DatabaseReference latitude_ref =
        FirebaseDatabase.instance.ref('gps-data/lat');
        latitude_ref.onValue.listen((DatabaseEvent event) {
            final data = event.snapshot.value;
            setState(() {
              latitude = data as double;
            });
        });

      DatabaseReference longitude_ref =
      FirebaseDatabase.instance.ref('gps-data/lng');
      longitude_ref.onValue.listen((DatabaseEvent event) {
          final data = event.snapshot.value;
          setState(() {
            longitude = data as double;
          });
      });

  }
  usermark(var lat, var lng){
      _mapcontrol.move(LatLng(lat,lng), 13);
      Marker(point: LatLng(lat,lng), 
      builder: (context) => new Container(
                child: IconButton(
                  icon: Icon(Icons.supervised_user_circle),
                  color: Colors.yellow,
                  iconSize: 45.0,
                  onPressed: () {
                    print('marker user tapped');
                  },
            
                )
                )
      );
    }
}
