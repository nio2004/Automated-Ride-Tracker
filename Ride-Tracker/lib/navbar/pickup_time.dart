import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:automated_ride_tracker/loginpage.dart';

class Pickup extends StatefulWidget {
  const Pickup({super.key});

  @override
  State<Pickup> createState() => _PickupState();
}

class _PickupState extends State<Pickup> {
  bool isshow = true;
  final userid = FirebaseAuth.instance.currentUser!.uid;
  final useremail = FirebaseAuth.instance.currentUser!.email;
  DateTime _dateTime = DateTime.now();
  List<String> destination = ['VIT', 'VIIT', 'PICT'];
  String? type;
  String? selectedvalue = 'VIT';
  var st = 'no request';

  Future<void> postDetailsToRealdb(var id, var mail, var time, var date,
      var routetype, var destination) async {
    var dbaseRef = FirebaseDatabase.instance.ref('pickup-drop');
    try {
      if (routetype == 'pick') {
        setState(() {
          destination = 'Hostel';
        });
      }
      await dbaseRef.child('$id').set({
        'email': '$mail',
        'date': '$date',
        'destination': '$destination',
        'time': '$time',
        'type': '$routetype',
      });
    } catch (e) {
      print('Error posting data: $e');
    }
  }

  @override
  void initState() {
    searchstatus(userid);
  }

  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color.fromARGB(222, 222, 222, 222),
        appBar: AppBar(
          title: Text("Pickup Time"),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Container(
                    color: Colors.blueGrey,
                    child: SizedBox(
                      height: 100,
                      child: CupertinoDatePicker(
                        use24hFormat: true,
                        initialDateTime: DateTime(DateTime.now().year,
                            DateTime.now().month, DateTime.now().day, 7, 30),
                        minimumDate: DateTime(DateTime.now().year,
                            DateTime.now().month, (DateTime.now().day), 7, 30),
                        maximumDate: DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            (DateTime.now().day) + 1,
                            19,
                            30),
                        minuteInterval: 30,
                        onDateTimeChanged: (dateTime) {
                          //print(dateTime);
                          setState(() {
                            _dateTime = dateTime;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 75),
                  child: SizedBox(
                      height: 150,
                      width: 350,
                      child: Column(
                        children: [
                          RadioListTile(
                              tileColor: Colors.transparent,
                              title: Text(
                                "Pick(from college to hostel)",
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                              value: "pick",
                              groupValue: type,
                              onChanged: (value) {
                                setState(() {
                                  type = value.toString();
                                  isshow = false;
                                });
                              }),
                          RadioListTile(
                              title: Text(
                                "Drop(from hostel to college)",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20),
                              ),
                              value: "drop",
                              groupValue: type,
                              onChanged: (value) {
                                setState(() {
                                  type = value.toString();
                                  isshow = true;
                                });
                              })
                        ],
                      )),
                ),
                Visibility(
                  visible: isshow,
                  child: SizedBox(
                    height: 100,
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.teal),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButton<String>(
                        value: selectedvalue,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 30,
                        elevation: 16,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        items: destination
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item,
                                      style: TextStyle(fontSize: 18)),
                                ))
                            .toList(),
                        onChanged: (item) =>
                            setState(() => selectedvalue = item),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlue,
                      onPrimary: Colors.white,
                      elevation: 5,
                      padding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Confirm",
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () async {
                      searchstatus(userid);
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title:
                              Text('the date and time you selected and type'),
                          content: Text('status=$userid'),

                          //content: Text('${_dateTime.day}/${_dateTime.month}/${_dateTime.year}\n${_dateTime.hour}/${_dateTime.minute}\n${type}\n${selectedvalue}'),
                        ),
                      );
                      searchstatus(userid);
                      await postDetailsToRealdb(
                          userid,
                          useremail,
                          '${_dateTime.hour}:${_dateTime.minute}',
                          '${_dateTime.day}:${_dateTime.month}:${_dateTime.year}',
                          type,
                          selectedvalue);
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlue,
                      onPrimary: Colors.white,
                      elevation: 5,
                      padding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Delete Request",
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () async {
                      searchstatus(userid);
                      await deleteReq(userid);
                      searchstatus(userid);
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  height: 100,
                  width: 200,
                  // decoration: BoxDecoration(color: Colors.amber),
                  child: Center(
                    child: SizedBox(
                      height: 100,
                      child: Text(
                        "Status= $st",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  // statusVal(){
  //   return Text
  // }

  deleteReq(var id) {
    DatabaseReference dRef = FirebaseDatabase.instance.ref('pickup-drop');
    dRef.child('$id').remove();
    setState(() {
      st = 'no request';
    });
  }

  searchstatus(var id) async {
    DatabaseReference searchRef = FirebaseDatabase.instance.ref('pickup-drop');
    final snapshot = await searchRef.get();
    List list = [];
    final map = snapshot.value as Map<dynamic, dynamic>;
    map.forEach((key, value) {
      //final user = User.fromMap(value);

      list.add(key);
    });
    var flag = 0;
    for (var i = 0; i < list.length; i++) {
      if (list[i] == '$id') {
        flag = 1;
      }
    }
    if (flag == 1) {
      setState(() {
        st = 'requested';
      });
    } else {
      setState(() {
        st = 'no request';
      });
    }
  }
}
