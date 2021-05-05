import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String text = "";
  CollectionReference tripdata = FirebaseFirestore.instance.collection("tripdata");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("En uzun 5 yolculuk"),
          centerTitle: true,
        ),
        body: Center(child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text,style: TextStyle(fontSize: 20,color: Colors.blue),),
              ElevatedButton(
                onPressed: () async{
                  text = "";
                  var querysnapshot = await tripdata.orderBy('trip_distance').limitToLast(5).get();
                  for(int i=0;i<querysnapshot.docs.length;i++){
                    print(querysnapshot.docs[i].data()["trip_distance"]);
                    text += querysnapshot.docs[i].data()['tpep_dropoff_datetime'].toString()+" "+querysnapshot.docs[i].data()['trip_distance'].toString()+"\n";
                  }
                  setState(() {

                  });
                },
                child: Text('göster'),
              ),
            ]
        ))
    );
  }
}
