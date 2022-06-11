// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetes_prediction/models/data_model.dart';
import 'package:diabetes_prediction/pages/diet_exercise/diet_exercise.dart';
import 'package:diabetes_prediction/widgets/app_text_large.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PredictPage extends StatefulWidget {
  final String? gender;

  const PredictPage({Key? key, required this.gender}) : super(key: key);

  @override
  State<PredictPage> createState() => _PredictPageState();
}

class _PredictPageState extends State<PredictPage> {
  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

  final TextEditingController noOfTimesPregnant = TextEditingController();
  final TextEditingController glucose = TextEditingController();
  final TextEditingController bloodPressure = TextEditingController();
  final TextEditingController skinThickness = TextEditingController();
  final TextEditingController insulinLevel = TextEditingController();
  final TextEditingController bmi = TextEditingController();
  final TextEditingController age = TextEditingController();

  String name = "";
  dynamic res;
  dynamic pred;
  bool isDiabetic = false;
  bool isRes = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
          child: Column(
            children: [
              AppLargeText(text: "Check your diabetes status"),
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    widget.gender == "Female"
                        ? const SizedBox(height: 20)
                        : Container(),
                    widget.gender == "Female"
                        ? predictForm(
                            noOfTimesPregnant,
                            "No. of Pregnanancies",
                            "count",
                            "Please enter No. of times Pregnant",
                            "count")
                        : Container(),
                    const SizedBox(height: 20),
                    predictForm(glucose, "Glucose Level", "140 to 199 mg/dl",
                        "Please enter Glucose Level", "mg/dl"),
                    const SizedBox(height: 20),
                    predictForm(
                        bloodPressure,
                        "Blood Pressure",
                        "90 to 120 mmHg",
                        "Please enter Blood Pressure",
                        "mmHg"),
                    const SizedBox(height: 20),
                    predictForm(skinThickness, "Skin Thickness", "0.5 to 5 mm",
                        "Please enter Skin Thickness", "mm"),
                    const SizedBox(height: 20),
                    predictForm(
                        insulinLevel,
                        "Insulin Level",
                        "30 to 230 ml/UL",
                        "Please enter Insulin Level",
                        "ml/UL"),
                    const SizedBox(height: 20),
                    predictForm(bmi, "BMI", "18.5 to 30 kg/m2",
                        "Please enter BMI", "kg/m2"),
                    const SizedBox(height: 20),
                    predictForm(
                        age, "Age", "years", "Please enter Age", "years"),
                    const SizedBox(height: 30),
                    ElevatedButton.icon(
                      onPressed: () {
                        predict();
                      },
                      icon: (isLoading)
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ))
                          : const Icon(Icons.arrow_forward),
                      label: (isLoading)
                          ? const Text(
                              "Predicting",
                              style: TextStyle(fontSize: 20),
                            )
                          : const Text(
                              "Predict",
                              style: TextStyle(fontSize: 20),
                            ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(150, 40),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    isDiabetic ? diabetesDetected() : 
                    isRes && !isDiabetic ? diabetesNotDetected() : Container()
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void predict() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      FocusManager.instance.primaryFocus?.unfocus();
      final response = await http.post(
          Uri.parse("https://diabetes-73.herokuapp.com/predict"),
          body: json.encode({
            'pregnant':
                widget.gender == "Female" ? noOfTimesPregnant.text : "0",
            'glucose': glucose.text,
            'bp': bloodPressure.text,
            'skin': skinThickness.text,
            'insulin': insulinLevel.text,
            'bmi': bmi.text,
            'age': age.text
          }));
      final decode = json.decode(response.body) as Map<String, dynamic>;
      setState(() {
        res = decode['result'];
        pred = decode['prediction'];
        print(res);
        print(pred);
        isRes = true;
        isLoading = false;
        if (pred.toString() == "1") {
          isDiabetic = true;
        } else {
          isDiabetic = false;
        }
      });
    }
    postDetailsToFirestore();
  }

  postDetailsToFirestore() async {
    print("Hello");
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    DataModel dataModel = DataModel();
    dataModel.pregnant =
        widget.gender == "Female" ? noOfTimesPregnant.text : "0";
    dataModel.glucose = glucose.text;
    dataModel.bp = bloodPressure.text;
    dataModel.skin = skinThickness.text;
    dataModel.insulin = insulinLevel.text;
    dataModel.bmi = bmi.text;
    dataModel.age = age.text;
    dataModel.result = res.toString();
    dataModel.prediction = pred.toString();
    dataModel.timestamp = DateTime.now().toString();

    await firebaseFirestore.collection("history").doc(user!.uid).set({
      "Myhistory": FieldValue.arrayUnion([dataModel.toMap()])
    }, SetOptions(merge: true));

    setState(() {
      isLoading = false;
    });
  }

  Widget predictForm(controller, labeltext, helpertext, errormsg, unit) {
    return TextFormField(
      autofocus: false,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        controller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          labelText: labeltext,
          helperText: helpertext,
          suffixText: unit,
          // prefixIcon: const Icon(
          //   Icons.mail,
          //   color: Color(0xFF989acd),
          // ),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          // hintText: "Glucose Level",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          // fillColor: AppColors.buttonBackground,
          filled: false),
      validator: (value) {
        if (value!.isEmpty) {
          return errormsg;
        }
        return null;
      },
    );
  }

  Widget diabetesDetected() {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Column(
        children: [
          Container(
            color: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 16.2, vertical: 15),
            child: Text(
              "YOU MIGHT BE AT RISK OF DIABETES",
              textScaleFactor: 1.35,
              style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: "Model Confidence - ",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                TextSpan(
                    text: "$res %",
                    style: TextStyle(
                        backgroundColor: Colors.amberAccent.withOpacity(0.5),
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              ]),
            ),
          ),
          Divider(
            color: Colors.black,
            height: 5,
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: "DON'T PANIC - ",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                TextSpan(
                    text: "There are currently more than ",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                    )),
                TextSpan(
                    text: "500 million",
                    style: TextStyle(
                        backgroundColor: Colors.amberAccent.withOpacity(0.5),
                        color: Colors.black,
                        fontSize: 18)),
                TextSpan(
                    text:
                        " people globally living happily alongwith diabetes with slight changes to their lifestyle.",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                    )),
              ]),
            ),
          ),
          Divider(
            color: Colors.black,
            height: 5,
          ),
          Container(
            child: OutlinedButton(
              child: Text(
                "Diet and Exercise Plan",
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DietExercise()));
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(width: 1.0, color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget diabetesNotDetected() {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.zero,
            color: Colors.green,
            padding: EdgeInsets.symmetric(horizontal: 20.5, vertical: 15),
            child: Text(
              "YOU ARE NOT AT RISK OF DIABETES",
              textScaleFactor: 1.35,
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: "Model Confidence - ",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                TextSpan(
                    text: "$res %",
                    style: TextStyle(
                        backgroundColor: Colors.amberAccent.withOpacity(0.5),
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              ]),
            ),
          ),
          Divider(
            color: Colors.black,
            height: 5,
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: RichText(
              textAlign: TextAlign.justify,
              text: const TextSpan(children: <TextSpan>[
                TextSpan(
                    text: "Do's and Dont's to keep Diabetes at Bay - ",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                    )),
                TextSpan(
                    text: "Know-More",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blueAccent,
                        fontSize: 18)),
              ]),
            ),
          ),
          Divider(
            color: Colors.black,
            height: 5,
          ),
          Container(
            child: OutlinedButton(
              child: Text("Diet and Exercise Plan",
                  style: TextStyle(color: Colors.blue, fontSize: 16)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DietExercise()));
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(width: 1.0, color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
