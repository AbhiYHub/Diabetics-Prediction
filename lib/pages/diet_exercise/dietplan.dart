import 'dart:convert';

import 'package:diabetes_prediction/pages/diet_exercise/detailpage.dart';
import 'package:diabetes_prediction/widgets/app_text_large.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DietPlan extends StatefulWidget {
  const DietPlan({Key? key}) : super(key: key);

  @override
  State<DietPlan> createState() => _DietPlanState();
}

class _DietPlanState extends State<DietPlan> {
  List _diet = [];
  List _timetable = [];

  Future<void> readJsonDiet() async {
    final String response =
        await rootBundle.loadString('assets/json/diet_exercise_plan.json');
    final data = await json.decode(response);
    setState(() {
      _diet = data["diet"];
      _timetable = data["timetable"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJsonDiet();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Diet Plan"),
            centerTitle: true,
            bottom: const TabBar(tabs: [
              Tab(icon: Icon(Icons.food_bank), text: "Foods"),
              Tab(icon: Icon(Icons.schedule), text: "Timetable")
            ]),
          ),
          body: TabBarView(
            children: [foods(), timetable()],
          )),
    );
  }

  Widget foods() {
    return _diet.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: _diet.length,
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
                                      img: "diet/" + _diet[index]["img"],
                                      name: _diet[index]["title"],
                                      description: _diet[index]
                                          ["long_description"],
                                    )));
                      },
                      child: ListTile(
                        leading: Hero(
                            tag: "hero${_diet[index]["title"]}",
                            child: Image.asset(
                                "assets/img/diet/" + _diet[index]["img"])),
                        title: Text(_diet[index]["title"],
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(_diet[index]["description"],
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
        : const CircularProgressIndicator();
  }

  Widget timetable() {
    if (_timetable.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            AppLargeText(
                text: "1200 Calorie Diabetic Diet Plan"),
            const SizedBox(height: 10),
            const Text(
                "A proper diabetic meal plan goes a long way in helping control high blood sugar levels. So, we have put together a 1200 calorie Indian diabetic diet plan to help you understand how you can plan your meals in order to bring diabetes under control.",
                style: TextStyle(color: Colors.black54, fontFamily: 'Poppins', fontSize: 13),
                textAlign: TextAlign.justify),
            const SizedBox(height: 20),
            DataTable(
                columnSpacing: 30,
                dataRowHeight: 90,
                headingRowColor: MaterialStateColor.resolveWith(
                  (states) {
                    return Colors.grey.shade300;
                  },
                ),
                columns: const [
                  DataColumn(
                      label: Expanded(
                    child: Text("Time",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
                  )),
                  DataColumn(
                      label: Text("Meal",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins'
                          )))
                ],
                rows: _createRow())
          ],
        ),
      );
    } else {
      return const CircularProgressIndicator();
    }
  }

  List<DataRow> _createRow() {
    return _timetable
        .map((obj) => DataRow(cells: [
              DataCell(SizedBox(
                child: Text(obj["time"], style: const TextStyle(fontFamily: 'Poppins', fontSize: 13)),
                width: 60,
              )),
              DataCell(Text(obj["meal"], style: const TextStyle(fontFamily: 'Poppins', fontSize: 13)))
            ]))
        .toList();
  }
}
