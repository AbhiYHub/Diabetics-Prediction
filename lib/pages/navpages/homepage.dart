// ignore_for_file: prefer_const_constructors

import 'package:diabetes_prediction/widgets/carousel.dart';
import 'package:diabetes_prediction/widgets/app_text_large.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Carousel(),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppLargeText(text: "What is Diabetes?"),
                const SizedBox(height: 10),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 15),
                    child: Text(
                      "Diabetes is a chronic (long-lasting) health condition that affects how your body turns food into energy. Most of the food you eat is broken down into sugar (also called glucose) and released into your bloodstream. When your blood sugar goes up, it signals your pancreas to release insulin.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                AppLargeText(text: "Some facts about Diabetes"),
                const SizedBox(height: 10),
                // 1st
                oddFacts("fact1.png",
                    "India has over 65.1 million diabetics. Diabetes is a condition in which your body does not make enough insulin to keep your blood sugar levels steady."),
                const SizedBox(height: 20),
                // 2nd
                evenFacts("fact2.png",
                    "There are 3 types of Diabetes which are Type 1, Type 2 and gestational. Over 420 million people in the world have some form of diabetes."),
                const SizedBox(height: 20),
                // 3rd
                oddFacts("fact3.png",
                    "About 90-95 percent of people with diabetes have Type 2, while about 5 percent have Type 1, and the remainder have gestational diabetes."),
                const SizedBox(height: 20),
                // 4th
                evenFacts("fact4.png",
                    "Diabetes planning doesn't have to be Complicated. The main dietary restrictions with diabetes are avoiding excess sugar, unhealthy fats, sodium and cholesterol."),
                const SizedBox(height: 20),
                // 5th
                oddFacts("fact5.png",
                    "Type 1 diabetes usually develops early in life, and has been known previously as insulin-dependent or juvenile diabetes."),
                const SizedBox(height: 20),
                // 6th
                evenFacts("fact6.png",
                    "People with diabetes can still live well in spite of their condition. The ways that they can stay well are not much different from the ways that everyone else does."),
                const SizedBox(height: 20),
              ],
            ),
          )
        ],
      ),
    ));
  }

  Widget evenFacts(img, fact) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                height: MediaQuery.of(context).size.width * 0.30,
                width: MediaQuery.of(context).size.width * 0.62,
                // color: Colors.amberAccent,
                child: Center(
                  child: Text(
                    fact,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: Colors.lightGreenAccent,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                child: Image.asset('assets/img/facts/' + img,
                    height: MediaQuery.of(context).size.width * 0.30,
                    width: MediaQuery.of(context).size.width * 0.25),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget oddFacts(img, fact) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                color: Colors.lightBlueAccent,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                child: Image.asset('assets/img/facts/' + img,
                    height: MediaQuery.of(context).size.width * 0.30,
                    width: MediaQuery.of(context).size.width * 0.25),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.30,
              width: MediaQuery.of(context).size.width * 0.62,
              // color: Colors.amberAccent,
              child: Center(
                child: Text(
                  fact,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
