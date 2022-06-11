import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetes_prediction/models/user_model.dart';
import 'package:diabetes_prediction/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:diabetes_prediction/pages/navpages/predict_page.dart';
import 'package:diabetes_prediction/pages/navpages/homepage.dart';
import 'package:diabetes_prediction/pages/navpages/faq_page.dart';
import 'package:diabetes_prediction/pages/navpages/about_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  User? user = FirebaseAuth.instance.currentUser;
  UserModel userModel = UserModel();
  var gender1;

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      userModel = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    List pages = [
      const HomePage(),
      PredictPage(
        gender: userModel.gender,
      ),
      const AboutPage(),
      const FAQPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Diabetes Prediction"),
        centerTitle: true,
        // toolbarHeight: 55,
        backgroundColor: Colors.blueAccent.shade700,
        // actions: [
        //   Container(
        //     margin: const EdgeInsets.only(right: 20, top: 7, bottom: 7),
        //     width: 40,
        //     height: 40,
        //     alignment: Alignment.center,
        //     decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(10),
        //         color: Colors.grey.withOpacity(0.5)),
        //     child: AppLargeText(
        //       text: userModel.name![0],
        //       // color: AppColors.mainColor,
        //       // text: "A",
        //     ),
        //   )
        // ],
      ),
      backgroundColor: Colors.white,
      drawer: MyDrawer(
        name: userModel.name,
        email: userModel.email,
        dob: userModel.dob,
        gender: userModel.gender,
        height: userModel.height,
        weight: userModel.weight,
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Colors.blue.shade600,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        elevation: 5,
        items: const [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              label: "Predict", icon: Icon(Icons.bar_chart_sharp)),
          BottomNavigationBarItem(label: "About", icon: Icon(Icons.info)),
          BottomNavigationBarItem(
              label: "FAQ", icon: Icon(Icons.question_answer)),
        ],
      ),
    );
  }
}
