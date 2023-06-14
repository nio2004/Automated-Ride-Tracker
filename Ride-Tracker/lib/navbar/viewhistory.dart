import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class historydisplay extends StatefulWidget {
  const historydisplay({super.key});
  @override
  State<historydisplay> createState() => _historydisplayState();
}

class _historydisplayState extends State<historydisplay> {
  Map<int, String> ridedata = {};

  @override
  void initState() {
    super.initState();
    gethistory();
  }

  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("History"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 50, left: 20, right: 20),
                child: Container(
                  height: 75,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "Check your previous rides here",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 500,
                child: ListView.builder(
                  itemCount: ridedata.length,
                  itemBuilder: (BuildContext context, int index) {
                    return MySquare(
                      //title: Text('$index')
                      child: '${index + 1}',
                      child2: '${ridedata[(ridedata.length - index)]}',
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );

  gethistory() async {
    DatabaseReference href = FirebaseDatabase.instance.ref('history');
    final snapshot = await href.get();
    final map = snapshot.value as Map<dynamic, dynamic>;
    var count = 1;
    map.forEach((key, value) async {
      //print(key);
      String str = key;
      DatabaseReference lref =
          FirebaseDatabase.instance.ref('history/$str/ListStudents');
      final snapshot1 = await lref.get();
      final map1 = snapshot1.value as Map<dynamic, dynamic>;
      var str1 = '';
      map1.forEach((key, value) {
        if (str1 == '') {
          str1 = str1 + '' + key;
        } else {
          str1 = str1 + ',' + key;
        }
      });
      print('test' + str1);
      setState(() {
        ridedata[count] = '${str} \n        ${str1}';
      });
      count++;
    });
  }
}

class MySquare extends StatelessWidget {
  // const square({super.key});

  final String child;
  final String child2;
  MySquare({required this.child, required this.child2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 82, 144, 175),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(1),
              spreadRadius: 2,
              blurRadius: 1,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.blueGrey,
                child: Center(
                  child: Text(
                    child,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: Color.fromARGB(255, 13, 94, 155),
                child: Center(
                  child: Text(
                    child2,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
