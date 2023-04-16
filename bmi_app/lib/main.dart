import 'package:flutter/material.dart';
import 'input_page.dart';

void main() => runApp(BMICalculator());

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF1F184C),
        scaffoldBackgroundColor: Colors.blue,
      ),
      home: InputPage(),
    );
  }
}
[2:05 am, 17/04/2023] Muneeb Khokhar Uni: import 'package:flutter/material.dart';

const kactiveColor = Color(0xFF1D1E33);
const kinactiveColor = Color(0xFF111320);
const kBottomContainerHeight = 80.0;
const kBottomContainerColour = Colors.lightGreen;

const kbottemContainerStyle = TextStyle(
  fontSize: 30.0,
  fontWeight: FontWeight.bold,
);

const kLabelStyle = TextStyle(
  fontSize: 20.0,
);
const kNumberStyle = TextStyle(
  fontSize: 50.0,
  fontWeight: FontWeight.w900,
);

const kTitleTextStyle = TextStyle(
  fontSize: 50.0,
  fontWeight: FontWeight.bold,
);

const kResultTextStyle = TextStyle(
  color: Color(0xFF24D876),
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
);

const kBMITextStyle = TextStyle(
  fontSize: 100.0,
  fontWeight: FontWeight.bold,
);
const kBodyTextStyle = TextStyle(
  fontSize: 22.0,
);

const kLargeButtonTextStyle = TextStyle(
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
);
[2:05 am, 17/04/2023] Muneeb Khokhar Uni: import 'package:bmi_calculator_2022_updated/reultPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'reUseableCardWidgets.dart';
import 'reuseContainerWidget.dart';
import 'constantFile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Gender {
  male,
  female,
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender ? selectedGender;
  int height = 180;
  int weight = 60;
  int age = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ReuseableContainer(
                    onPress: () {
                      setState(() {
                        selectedGender = Gender.male;
                      });
                    },
                    colorr: selectedGender == Gender.male
                        ? kactiveColor
                        : kinactiveColor,
                    cardWidget: iconColumn(
                      icon: Icons.ac_unit_outlined,
                      label: "Male",
                    ),
                  ),
                ),
                Expanded(
                  child: ReuseableContainer(
                    onPress: () {
                      setState(() {
                        selectedGender = Gender.female;
                      });
                    },
                    colorr: selectedGender == Gender.female
                        ? kactiveColor
                        : kinactiveColor,
                    cardWidget: iconColumn(
                      icon: Icons.accessibility,
                      label: "Female",
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ReuseableContainer(
              colorr: kactiveColor,
              cardWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Height",
                    style: kLabelStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Text(
                        height.toString(),
                        style: kNumberStyle,
                      ),
                      Text(
                        "cm",
                        style: kLabelStyle,
                      ),
                    ],
                  ),
                  Slider(
                    activeColor: Colors.yellowAccent,
                    inactiveColor: Colors.lightGreenAccent,
                    value: height.toDouble(),
                    onChanged: (double newValue) {
                      setState(() {
                        height = newValue.round();
                      });
                    },
                    min: 120,
                    max: 220,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ReuseableContainer(
                    colorr: kactiveColor,
                    cardWidget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Weight",
                          style: kLabelStyle,
                        ),
                        Text(
                          weight.toString(),
                          style: kNumberStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  weight++;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  weight--;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ReuseableContainer(
                    colorr: kactiveColor,
                    cardWidget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Age",
                          style: kLabelStyle,
                        ),
                        Text(
                          age.toString(),
                          style: kNumberStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  age++;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  age--;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ResultPage()));
            },
            child: Container(
              margin: EdgeInsets.only(top: 10.0),
              padding: EdgeInsets.only(bottom: 20.0),
              width: double.infinity,
              height: 70.0,
              color: Colors.lightGreen,
              child: Center(
                child: Text(
                  "Calculate",
                  style: kbottemContainerStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Custom Class for Own Floating Action Buttons
class RoundIconButton extends StatelessWidget {
  RoundIconButton({required this.icon, required this.onPressed});
  final IconData icon;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      child: Icon(icon),
      elevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      fillColor: Colors.lightGreen,
      constraints: BoxConstraints.tightFor(width: 45.0, height: 45.0),
    );
  }
}

/*
  // Color maleColor = inactiveColor;
  // Color femaleColor = inactiveColor;
//1 for male and 2 for female
//   void upDateColor(Gender gender) {
//     if (gender == Gender.male) {
//       if (maleColor == inactiveColor) {
//         maleColor = activeColor;
//         femaleColor = inactiveColor;
//       } else {
//         maleColor = inactiveColor;
//       }
//     }
//     if (gender == Gender.female) {
//       if (femaleColor == inactiveColor) {
//         femaleColor = activeColor;
//         maleColor = inactiveColor;
//       } else {
//         femaleColor = inactiveColor;
//       }
//     }
//   }
 */
import 'package:flutter/material.dart';

const kBottomContainerHeight = 80.0;
const kActiveCardColour = Color(0xFF1D1E33);
const kInactiveCardColour = Color(0xFF111328);
const kBottomContainerColour = Color(0xFFEB1555);

const kLabelTextStyle = TextStyle(
  fontSize: 18.0,
  color: Color(0xFF8D8E98),
);

const kNumberTextStyle = TextStyle(
  fontSize: 50.0,
  fontWeight: FontWeight.w900,
);

const kLargeButtonTextStyle = TextStyle(
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
);

const kTitleTextStyle = TextStyle(
  fontSize: 50.0,
  fontWeight: FontWeight.bold,
);

const kResultTextStyle = TextStyle(
  color: Color(0xFF24D876),
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
);

const kBMITextStyle = TextStyle(
  fontSize: 100.0,
  fontWeight: FontWeight.bold,
);

const kBodyTextStyle = TextStyle(
  fontSize: 22.0,
);
import 'package:bmi_calculator_2022_updated/reUseableCardWidgets.dart';
import 'package:flutter/material.dart';
import 'bottomButton.dart';
import 'constantFile.dart';

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.bottomLeft,
              child: Text(
                'Your Result',
                style: kTitleTextStyle,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: ReuseableContainer(
              colorr: kactiveColor,
              cardWidget: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'resultText.toUpperCase()',
                    style: kResultTextStyle,
                  ),
                  Text(
                    'bmiResult',
//style: kBMITextStyle,
                  ),
                  Text(
                    'interpretation',
                    textAlign: TextAlign.center,
                    style: kBodyTextStyle,
                  ),
                ],
              ),
            ),
          ),
          BottomButton(
            buttonTitle: 'RE-CALCULATE',
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:bmi_calculator_2022_updated/constants.dart';

class IconContent extends StatelessWidget {
  IconContent({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 80.0,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          label,
          style: kLabelTextStyle,
        )
      ],
    );
  }
}
import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({required this.colour, required this.cardChild,  this.onPress});

  final Color colour;
  final Widget cardChild;
  final VoidCallback?  onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'constantFile.dart';

class BottomButton extends StatelessWidget {
  BottomButton({required this.onTap, required this.buttonTitle});

  final VoidCallback onTap;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(
          child: Text(
            buttonTitle,
            style: kLargeButtonTextStyle,
          ),
        ),
        color: kBottomContainerColour,
        margin: EdgeInsets.only(top: 10.0),
        padding: EdgeInsets.only(bottom: 20.0),
        width: double.infinity,
        height: kBottomContainerHeight,
      ),
    );
  }
}
import 'dart:math';

class CalculatorBrain {
  CalculatorBrain({required this.height, required this.weight});

  final int height;
  final int weight;

  double? _bmi;

  String calculateBMI() {
    _bmi = weight / pow(height / 100, 2);
    return _bmi!.toStringAsFixed(1);
  }

  String getResult() {
    if (_bmi !>= 25) {
      return 'Overweight';
    } else if (_bmi !> 18.5) {
      return 'Normal';
    } else {
      return 'Underweight';
    }
  }

  String getInterpretation() {
    if (_bmi !>= 25) {
      return 'You have a higher than normal body weight. Try to exercise more.';
    } else if (_bmi !>= 18.5) {
      return 'You have a normal body weight. Good job!';
    } else {
      return 'You have a lower than normal body weight. You can eat a bit more.';
    }
  }
}
import 'package:flutter/material.dart';

class ReuseableContainer extends StatelessWidget {
  final Color? colorr; //Color(0xFF1D1E33),
  final Widget? cardWidget;
  final VoidCallback? onPress;
  ReuseableContainer({required this.colorr, this.cardWidget,  this.onPress});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: cardWidget,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: colorr,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'constantFile.dart';

class iconColumn extends StatelessWidget {
  iconColumn({required this.icon, this.label});
  final IconData? icon;
  final String? label;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 50.0,
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          label.toString(),
          style: kLabelStyle,
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:bmi_calculator_2022_updated/constants.dart';
import 'package:bmi_calculator_2022_updated/components/reusable_card.dart';
import 'package:bmi_calculator_2022_updated/components/bottom_button.dart';

class ResultsPage extends StatelessWidget {
  ResultsPage(
      {required this.interpretation,
        required this.bmiResult,
        required this.resultText});

  final String bmiResult;
  final String resultText;
  final String interpretation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('BMI CALCULATOR'),
    ),
    body: Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.…
    import 'package:flutter/material.dart'


    class RoundIconButton extends StatelessWidget {
    RoundIconButton({required this.icon, required this.onPressed});

    final IconData icon;
    final VoidCallback onPressed;

    @override
    Widget build(BuildContext context) {
    return RawMaterialButton(
    elevation: 0.0,
    child: Icon(icon),
    onPressed: onPressed,
    constraints: BoxConstraints.tightFor(
    width: 56.0,
    height: 56.0,
    ),
    shape: CircleBorder(),
    fillColor: Color(0xFF4C4F5E),
    );
    }
    }
    ,);