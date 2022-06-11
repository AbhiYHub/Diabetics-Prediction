// import 'package:firebase_auth/firebase_auth.dart';
import 'package:diabetes_prediction/pages/diet_exercise/diet_exercise.dart';
import 'package:diabetes_prediction/pages/drawerpages/history.dart';
import 'package:diabetes_prediction/pages/drawerpages/profile.dart';
import 'package:diabetes_prediction/pages/login_register/login_register.dart';
import 'package:diabetes_prediction/widgets/app_text.dart';
import 'package:diabetes_prediction/widgets/app_text_large.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatelessWidget {
  final String? name;
  final String? email;
  final String? dob;
  final String? gender;
  final String? height;
  final String? weight;

  const MyDrawer({Key? key, required this.name, required this.email, this.dob, this.gender, this.height, this.weight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent.shade700),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: AppLargeText(
                    text: name![0], color: Colors.blueAccent.shade700),
                // child: Text("Abhi"),
              ),
              accountName:
                  AppText(size: 16, text: name.toString(), color: Colors.white),
              // Text("Abhi"),
              accountEmail: AppText(
                  size: 16, text: email.toString(), color: Colors.white),
            )),
        ListTile(
          leading: const Icon(Icons.home, color: Colors.black),
          title: const Text("Home", style: TextStyle(fontFamily: 'Poppins'),),
          onTap: () => {Navigator.pop(context)},
        ),
        ListTile(
          leading: const Icon(Icons.person, color: Colors.black),
          title: const Text("Profile", style: TextStyle(fontFamily: 'Poppins'),),
          onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(name: name.toString(), email: email.toString(), dob: dob.toString(), gender: gender.toString(), height: height.toString(), weight: weight.toString())))},
        ),
        ListTile(
          leading: const Icon(Icons.food_bank, color: Colors.black),
          title: const Text("Diet & Exercise Plan", style: TextStyle(fontFamily: 'Poppins'),),
          onTap: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const DietExercise())),
            // Navigator.pop(context)
          },
        ),
        ListTile(
          leading: const Icon(Icons.history, color: Colors.black),
          title: const Text("History", style: TextStyle(fontFamily: 'Poppins'),),
          onTap: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const History())),
            // Navigator.pop(context)
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.black),
          title: const Text("Logout", style: TextStyle(fontFamily: 'Poppins'),),
          onTap: () {
            _signOut(context);
          },
        ),
      ],
    ));
  }

  Future<void> _signOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginRegister()));
  }
}
