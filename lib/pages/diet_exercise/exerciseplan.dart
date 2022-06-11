import 'dart:convert';

import 'package:diabetes_prediction/pages/diet_exercise/detailpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExercisePlan extends StatefulWidget {
  const ExercisePlan({Key? key}) : super(key: key);

  @override
  State<ExercisePlan> createState() => _ExercisePlanState();
}

class _ExercisePlanState extends State<ExercisePlan> {
  List _exercise = [];

  Future<void> readJsonExercise() async {
    final String response =
        await rootBundle.loadString('assets/json/diet_exercise_plan.json');
    final data = await json.decode(response);
    setState(() {
      _exercise = data["exercise"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJsonExercise();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Exercise Plan"),
          centerTitle: true,
        ),
        body: _exercise.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _exercise.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Card(
                        elevation: 5,
                        // borderRadius: const BorderRadius.all(Radius.circular(10)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailsPage(
                                          img: "exercise/" +
                                              _exercise[index]["img"],
                                          name: _exercise[index]["title"],
                                          description: _exercise[index]
                                              ["long_description"],
                                        )));
                          },
                          child: ListTile(
                            leading: Hero(
                                tag: "hero${_exercise[index]["title"]}",
                                child: Image.asset("assets/img/exercise/" +
                                    _exercise[index]["img"])),
                            title: Text(_exercise[index]["title"],
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text(_exercise[index]["description"],
                                style: const TextStyle(
                                    fontFamily: 'Poppins', fontSize: 13)),
                            contentPadding: const EdgeInsets.all(15),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  );
                })
            : const CircularProgressIndicator());
  }
}
