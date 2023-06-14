import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


class RideStatus extends StatefulWidget {
  const RideStatus({super.key});

  @override
  State<RideStatus> createState() => _RideStatusState();
}

class _RideStatusState extends State<RideStatus> {
  Map req_info = {0:'none'};
  List ride_list =[];
  int len=0;
  var _dt = DateTime.now();
  @override
  @override
  void initState() {
    super.initState();
    reqlist();
  }
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 200,
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: len,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: Row(children : [SizedBox(width: 50),Text('${req_info[index].substring(req_info[index].indexOf('-')+1)}     '),
                  ElevatedButton(child: Text('+'),
                    onPressed: () {
                    setState(() {
                      if(isFound('${req_info[index]}') == false){
                      ride_list.insert(ride_list.length,'${req_info[index]}');
                      }
                    });
                  },),
                  ]
                )
                );
                  
                
                }
            ),
          ),
          SizedBox(
            height: 100,
            //padding: EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: ride_list.length,
              itemBuilder: (BuildContext context, int index) {
                return //height: 50,
                  //color: Colors.amber,
                  Center(child: Text('${ride_list[index].substring(ride_list[index].indexOf('-'))}\n'));
              }
            ),
          ),
          SizedBox(height: 50,),
          Container(
          child: Row(
            children: [
              SizedBox(width: 50),
              SizedBox(
              height: 50,
              width: 100,
              child: ElevatedButton(
              child: Text('Start Ride'),
              onPressed: (){
                rideHistory(ride_list, '${_dt.hour}:${_dt.minute}', '${_dt.day}-${_dt.month}-${_dt.year}');
              },
              )
            ),
            SizedBox(width: 50),
            SizedBox(
            height: 50,
            width: 100,
            child: ElevatedButton(
              child: Text('Delete List'),
              
              onPressed: (){
                
                setState(() {
                  ride_list = [];
                });
              },
            )),
          ])
          )
        ],
      ),
    )
  );
  reqlist() async {
    int c=0;
    DatabaseReference lref = FirebaseDatabase.instance.ref("pickup-drop");
    final snapshot = await lref.get();
    final map = snapshot.value as Map<dynamic, dynamic>;
    map.forEach((key, value) {
        setState(() {
          req_info[c] = '$key-${value['email']}-${value['type']}-${value['destination']}';   
        });
        c++;
      }
    );
  
    setState(() {
      len = c;
    });
  }
  isFound(var str){
    var flag=0;
    for(var i=0;i<ride_list.length;i++){
      if(str == ride_list[i]){
        flag=1;
        return true;
      }    
    }
    if (flag != 1) return false;
  }
  rideHistory(List l, var time, var date){
    final href = FirebaseDatabase.instance.ref('history');
    final pref = FirebaseDatabase.instance.ref('pickup-drop');
    var dt = DateTime.now();
    href.child('${dt.day}-${dt.month}-${dt.year}-${dt.hour}:${dt.minute}').set({
      'ListStudents': '',
      'time': '$time',
      'date': '$date',
    });
    for(int i=0; i< l.length; i++){
      final substr = l[i].substring(0,l[i].indexOf('-'));
      final str2 = l[i].substring(l[i].indexOf('-'));
      //pref.child('$substr').remove();
      print('$substr');
      href.child('${dt.day}-${dt.month}-${dt.year}-${dt.hour}:${dt.minute}/ListStudents').set({
        '$substr': '$str2',
    });
    }
    
    setState(() {
      ride_list = [];
    });
    // href.child('${dt.day}.${dt.month}.${dt.year}').set({

    // });
  }
  // updateHistory() async {
  //     DatabaseReference hRef = FirebaseDatabase.instance.ref('history');
  //     final snapshot = await hRef.get();
  //     var dt = DateTime.now();
  //     hRef.child('${dt.day}.${dt.month}.${dt.year}').set({

  //     });
    
    
  // }
}