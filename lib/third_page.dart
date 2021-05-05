import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {


  String text = "";
  CollectionReference tripdata =
      FirebaseFirestore.instance.collection("tripdata");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("En fazla yolcu sayısı"),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              text,
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            ElevatedButton(
              onPressed: () async {
                text = "";
                var querysnapshot = await tripdata
                    .orderBy('passenger_count')
                    .limitToLast(5)
                    .get();
                for (int i = 0; i < querysnapshot.docs.length; i++) {
                  text += querysnapshot.docs[i]
                          .data()['tpep_dropoff_datetime']
                          .toString() +
                      " " +
                      querysnapshot.docs[i]
                          .data()['passenger_count']
                          .toString() +
                      "\n";
                }
                setState(() {});
              },
              child: Text('göster'),
            ),
          ]),
        ),
      ),
    );
  }
}
