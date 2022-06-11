import 'package:diabetes_prediction/pages/diet_exercise/dietplan.dart';
import 'package:diabetes_prediction/pages/diet_exercise/exerciseplan.dart';
import 'package:flutter/material.dart';

class DietExercise extends StatefulWidget {
  const DietExercise({Key? key}) : super(key: key);

  @override
  State<DietExercise> createState() => _DietExerciseState();
}

class _DietExerciseState extends State<DietExercise> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Diabetes Prediction"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.37,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(11.0),
              image: const DecorationImage(
                image: AssetImage("assets/img/diet_exercise.png"),
                fit: BoxFit.contain,
              ),
            ),
            child: const Text('Diet and Exercise \nPlan',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontFamily: 'Poppins')),
            padding: const EdgeInsets.all(18),
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Material(
                elevation: 5,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DietPlan()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/img/diet.png", height: 90, width: 90),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Diet Plan       ",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Material(
                elevation: 5,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ExercisePlan()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/img/exercises.png", height: 90, width: 90),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Exercise Plan",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins'
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Expanded(
            child: Align(
              child: Padding(
                padding: EdgeInsets.only(bottom: 50.0),
                child: Text(
                  "A Healthy Outside Starts \nFrom The Inside",
                  style: TextStyle(
                      fontSize: 22,
                      // fontWeight: FontWeight.bold,
                      color: Colors.lightBlue,
                      fontFamily: 'Poppins'),
                  textAlign: TextAlign.center,
                ),
              ),
              alignment: FractionalOffset.bottomCenter,
            ),
          )
        ],
      ),
    );
  }
}
