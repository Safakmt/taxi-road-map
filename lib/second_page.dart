import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final _formKey = GlobalKey<FormState>();

  String firstdate;

  String seconddate;

  var loc, tripct = 0;

  String date;

  DateTime dt;
  double opc = 0.0;
  CollectionReference dateData =
      FirebaseFirestore.instance.collection('tripdata');

  CollectionReference locData =
      FirebaseFirestore.instance.collection('locations');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.yellow,
          title: Text("Belirli Lokasyondan Kalkan Araçlar")),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'İlk tarihi girin',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'lütfen tarih girin';
                }

                return null;
              },
              onSaved: (String value) {
                firstdate = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'İkinci tarihi girin',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'lütfen tarih girin';
                }
                return null;
              },
              onSaved: (String value) {
                seconddate = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Lokasyonu giriniz',
                hintText: "örn. Newark Airport",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'lütfen lokasyon girin';
                }

                return null;
              },
              onSaved: (String value) {
                loc = value;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                child: Text('Submit'),
                onPressed: () async {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  QuerySnapshot querysnapshot = await dateData
                      .where("tpep_pickup_datetime",
                          isGreaterThanOrEqualTo: firstdate,
                          isLessThanOrEqualTo: seconddate)
                      .orderBy("tpep_pickup_datetime")
                      .get();

                  QuerySnapshot querysnapshot2 =
                      await locData.where("Zone", isEqualTo: loc).get();

                  for (int i = 0; i < querysnapshot.docs.length; i++) {
                    if (querysnapshot.docs[i].data()["PULocationID"] ==
                        querysnapshot2.docs[0].data()["LocationID"]) tripct++;
                  }
                  setState(() {
                    opc = 1.0;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Opacity(
                opacity: opc,
                child: Text(
                    "Belirtilen tarihler arasında ${loc}dan hareket eden araç sayısı ${tripct}",
                    style: TextStyle(fontSize: 17)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
