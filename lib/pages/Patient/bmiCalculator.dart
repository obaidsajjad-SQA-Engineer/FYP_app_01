// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:patient_app/pages/common_widgets/drawer_widget.dart';
import 'package:patient_app/pages/constants.dart';

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  @override
  Widget build(BuildContext context) {
    return MyDrawer(
      mainScreen: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController feetController = TextEditingController();
  TextEditingController inchesController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  double bmiResult = 0.0;
  String bmiCategory = '';

  void calculateBMI() {
    double feet = double.parse(feetController.text);
    double inches = double.parse(inchesController.text);
    double heightInCm =
        (feet * 30.48) + (inches * 2.54); // Convert height to cm
    double weight = double.parse(weightController.text);

    double heightInMeters = heightInCm / 100; // Convert height to meters
    double bmi = weight / (heightInMeters * heightInMeters);

    String category;
    if (bmi < 18.5) {
      category = 'Underweight';
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      category = 'Normal weight';
    } else if (bmi >= 25 && bmi <= 29.9) {
      category = 'Overweight';
    } else {
      category = 'Obesity';
    }

    setState(() {
      bmiResult = bmi;
      bmiCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BMI Calculator',
        ),
        backgroundColor: backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: feetController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Feet'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: inchesController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Inches'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter Weight (kg)'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(buttonColor)),
              onPressed: () {
                if (feetController.text.isNotEmpty &&
                    inchesController.text.isNotEmpty &&
                    weightController.text.isNotEmpty) {
                  calculateBMI();
                } else {
                  // Handle empty fields
                  // You may show a Snackbar or a dialog here
                }
              },
              child: Text('Calculate BMI'),
            ),
            SizedBox(height: 16),
            Text(
              'BMI Result: ${bmiResult.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'BMI Category: $bmiCategory',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
