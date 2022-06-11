import 'package:diabetes_prediction/widgets/app_text_large.dart';
import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: AppLargeText(text: "Frequently Asked Questions"),
            ),
            const ExpansionTile(
                backgroundColor: Colors.black12,
                title: Text(
                  'Q-1: What should my blood sugar be?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Poppins',
                  ),
                  // textAlign: TextAlign.center,
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'A: The American Diabetes Association recommends a blood glucose range of 80-130 before meals and less than 180 about 2 hours after a meal. This range should place your A1c under 7.',
                      style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                      maxLines: 3,
                      softWrap: true,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
             const ExpansionTile(
                backgroundColor: Colors.black12,
                title: Text(
                  'Q-2: What is an A1c?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Poppins'
                  ),
                  // textAlign: TextAlign.center,
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'A: A Hemoglobin A1c is a 2-3 month average of your blood sugars. This result gives you a good idea of how well your diabetes is being managed/controlled. The American Diabetes Association recommends an A1c of less than 7 to keep the risk of complications low.',
                      style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                      maxLines: 3,
                      softWrap: true,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const ExpansionTile(
                backgroundColor: Colors.black12,
                title: Text(
                  'Q-3: What can I eat if I have diabetes?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Poppins'
                  ),
                  // textAlign: TextAlign.center,
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'A: You can eat just about anything you want. It is about knowing proper portion sizes and how much you are putting on your plate. A dietitian can help you learn to count carbohydrates and with meal planning that is specific for you.',
                      style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                      maxLines: 3,
                      softWrap: true,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const ExpansionTile(
                backgroundColor: Colors.black12,
                title: Text(
                  'Q-4: Why does it matter if my blood sugar is 120 or 200?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Poppins'
                  ),
                  // textAlign: TextAlign.center,
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'A: It is very important to keep your blood sugar level under control. When your blood sugar level is high, it can cause damage in your veins and arteries. This damage could lead to complications later such as heart attacks, strokes, kidney disease, neuropathies, vision problems, etc.',
                      style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                      maxLines: 3,
                      softWrap: true,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const ExpansionTile(
                backgroundColor: Colors.black12,
                title: Text(
                  'Q-5: Do I need to follow a low carb diet?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Poppins'
                  ),
                  // textAlign: TextAlign.center,
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'A: Carbohydrates are an important part of a healthy diet. With diabetes, watching portion sizes and getting most of your carbs from fruits, vegetables, whole grains and low fat milk and yogurt is key. Besides counting carbs, people with diabetes can also benefit from eating lower fat, high fiber foods and just enough calories to maintain a healthy weight.',
                      style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                      maxLines: 3,
                      softWrap: true,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}