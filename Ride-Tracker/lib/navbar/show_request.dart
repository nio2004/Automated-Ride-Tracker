import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ViewReq extends StatefulWidget {
  const ViewReq({super.key});

  @override
  State<ViewReq> createState() => _ViewReqState();
}

class _ViewReqState extends State<ViewReq> {
  final userid = FirebaseAuth.instance.currentUser!.uid;
  List info = [];
  Map req_info = {
    0: '1',
    1: 'none',
    2: 'none',
    3: 'none',
    4: 'none',
    5: 'none',
    6: 'none',
    7: 'none',
    8: 'none',
    9: 'none',
    10: 'none',
    11: 'none',
    12: 'none',
    13: 'none',
    14: 'none',
    15: 'none',
    16: 'none',
    17: 'none',
    18: 'none',
    19: 'none',
    20: 'none',
    21: 'none',
    22: 'none',
    23: 'none',
    24: 'none',
    25: 'none',
    26: 'none',
  };
  Map index_count = {
    0: '1',
    1: 'none',
    2: 'none',
    3: 'none',
    4: 'none',
    5: 'none',
    6: 'none',
    7: 'none',
    8: 'none',
    9: 'none',
    10: 'none',
    11: 'none',
    12: 'none',
    13: 'none',
    14: 'none',
    15: 'none',
    16: 'none',
    17: 'none',
    18: 'none',
    19: 'none',
    20: 'none',
    21: 'none',
    22: 'none',
    23: 'none',
    24: 'none',
    25: 'none',
    26: 'none',
  };
  //Map no_req = {0:req_per_slot('7:00'),};
  Map times = {
    0: '7:00',
    1: '7:30',
    2: '8:00',
    3: '8:30',
    4: '9:00',
    5: '9:30',
    6: '10:00',
    7: '10:30',
    8: '11:00',
    9: '11:30',
    10: '12:00',
    11: '12:30',
    12: '13:00',
    13: '13:30',
    14: '14:00',
    15: '14:30',
    16: '15:00',
    17: '15:30',
    18: '16:00',
    19: '16:30',
    20: '17:00',
    21: '17:30',
    22: '18:00',
    23: '18:30',
    24: '19:00',
    25: '19:30',
    26: '20:00',
  };
  @override
  void initState() {
    super.initState();
    req_per_slot();
  }

  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text("Requests"),
      ),
      body: Center(
          child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                'https://globaltimbertrackingnetwork.org/wp-content/uploads/2017/11/background-2462431_1280-e1515769124248.jpg'),
          ),
        ),
        alignment: Alignment.centerLeft,
        child: Timeline.tileBuilder(
          builder: TimelineTileBuilder.fromStyle(
            contentsAlign: ContentsAlign.reverse,
            contentsBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(times[index].toString()),
            ),
            oppositeContentsBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: Text('View->${index_count[index]}'),
                //req_per_slot($times[index]),
                onPressed: () {
                  reqlist(times[index]);
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                        title: Text(times[index].toString()),
                        content: SizedBox(
                            width: 100,
                            height: 200,
                            child: ListView.builder(
                                padding: const EdgeInsets.all(8),
                                itemCount: index_count[index],
                                itemBuilder: (BuildContext context, int index) {
                                  return
                                      //height: 50,
                                      //color: Colors.amber,
                                      Center(
                                          child: Text('${req_info[index]}\n'));
                                }))),
                  );
                },
              ),
            ),
            itemCount: 26,
          ),
        ),
      )));
  Future req_per_slot() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("pickup-drop");
    final snapshot = await ref.get();
    int count;
    var t;
    final map = snapshot.value as Map<dynamic, dynamic>;
    var dt = DateTime.now();
    for (int i = 0; i < 27; i++) {
      count = 0;
      t = times[i];
      map.forEach((key, value) {
        //print(value['time']+'$t');
        //print('${value['date']} and ${dt.day}:${dt.month}:${dt.year}');
        if (value['time'] == "$t" &&
            value['date'] == "${dt.day}:${dt.month}:${dt.year}") {
          count++;
          print("done");
        }
      });
      print('$t');
      setState(() {
        index_count[i] = count;
      });
    }
    print('DATE=${dt.day}:${dt.month}:${dt.year}');
  }

  reqlist(var time) async {
    int c = 0;
    DatabaseReference lref = FirebaseDatabase.instance.ref("pickup-drop");
    final snapshot = await lref.get();
    final map = snapshot.value as Map<dynamic, dynamic>;
    map.forEach((key, value) {
      if (value['time'] == '$time') {
        setState(() {
          req_info[c] =
              '${value['email']}-${value['type']}-${value['destination']}';
        });
        c++;
      }
    });
  }
}
