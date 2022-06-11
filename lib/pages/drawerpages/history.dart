import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetes_prediction/models/data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  User? user = FirebaseAuth.instance.currentUser;
  DataModel dataModel = DataModel();

  List history = [];

  Future<List> fetchAllHistory() async {
    List historyList = [];
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('history')
        .doc(user!.uid)
        .get();
    historyList = (documentSnapshot.data() as Map)['Myhistory'];
    return historyList;
  }

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection("history")
        .doc(user?.uid)
        .get()
        .then((value) {
      dataModel = DataModel.fromMap(value.data());
      setState(() {});
    });

    fetchAllHistory().then((List list) {
      setState(() {
        history = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Diabetes Prediction"),
        centerTitle: true,
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            padding: const EdgeInsets.all(5),
            itemCount: history.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Material(
                    elevation: 5,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(10)),
                    child: Column(
                      children: [
                        showData(
                            label: "Pregnancies",
                            value: history[index]['pregnant']),
                        showData(
                            label: "Glucose",
                            value: history[index]['glucose']),
                        showData(
                            label: "Blood Pressure",
                            value: history[index]['bp']),
                        showData(
                            label: "Skin Thickness",
                            value: history[index]['skin']),
                        showData(
                            label: "Insulin Level",
                            value: history[index]['insulin']),
                        showData(
                            label: "BMI", 
                            value: history[index]['bmi']),
                        showData(
                            label: "Age", 
                            value: history[index]['age']),
                        showData(
                            label: "Result",
                            value: history[index]['result']),
                        showData(
                            label: "Timestamp",
                            value: history[index]['timestamp'].toString().substring(1, 19)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              );
            }),
      ),
    );
  }

  Widget showData({label, value}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins', fontSize: 13),
            ),
          ),
          const Text(
            ":",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            value,
            style: const TextStyle(fontFamily: 'Poppins', fontSize: 13),
          ),
        ],
      ),
    );
  }
}
