import 'package:bmi_calculater/calculator_brain.dart';
import 'package:bmi_calculater/reusable_widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../reusable_widgets/icon_content.dart';
import '../reusable_widgets/reusable_card.dart';
import '../constants.dart';
import 'result_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../reusable_widgets/reusable_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum Gender { male, female, empty }

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  int height = 180;
  int weight = 60;
  int age = 18;
  Gender selectedGender = Gender.empty;
  bool genderSelection() {
    if (selectedGender == Gender.empty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI CALCULATOR'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    onPressed: () {
                      setState(() {
                        selectedGender = Gender.male;
                      });
                    },
                    colour: selectedGender == Gender.male
                        ? kActiveColor
                        : kInActiveColor,
                    cardChild: GenderWidget(
                      label: "MALE",
                      icon: FontAwesomeIcons.mars,
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    onPressed: () {
                      setState(() {
                        selectedGender = Gender.female;
                      });
                    },
                    colour: selectedGender == Gender.female
                        ? kActiveColor
                        : kInActiveColor,
                    cardChild: GenderWidget(
                      label: "FEMALE",
                      icon: FontAwesomeIcons.venus,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ReusableCard(
              colour: kActiveColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('HEIGHT', style: kLabelTextStyle),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        height.toString(),
                        style: kValueTextStyle,
                      ),
                      Text('cm', style: kLabelTextStyle)
                    ],
                  ),
                  SizedBox(
                    width: 320.0.w,
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                          thumbColor: const Color(0xFFEB1555),
                          trackHeight: 1,
                          inactiveTrackColor: const Color(0xFF8D9E98),
                          activeTrackColor: Colors.white,
                          overlayColor: const Color(0x29EB1555),
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 12.0.r),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 30.0.r)),
                      child: Slider(
                        min: 120.0,
                        max: 220.0,
                        value: height.toDouble(),
                        onChanged: (newValue) =>
                            setState(() => height = newValue.round()),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ReusableCard(
                    colour: kActiveColor,
                    cardChild: Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('WEIGHT', style: kLabelTextStyle),
                          Text(
                            weight.toString(),
                            style: kValueTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundIconButton(
                                  onPressed: () {
                                    setState(() {
                                      weight++;
                                    });
                                  },
                                  icon: FontAwesomeIcons.plus),
                              SizedBox(width: 15.0.w),
                              RoundIconButton(
                                  onPressed: () {
                                    setState(() {
                                      weight--;
                                    });
                                  },
                                  icon: FontAwesomeIcons.minus)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colour: kActiveColor,
                    cardChild: Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('AGE', style: kLabelTextStyle),
                          Text(
                            age.toString(),
                            style: kValueTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundIconButton(
                                  onPressed: () {
                                    setState(() {
                                      age++;
                                    });
                                  },
                                  icon: FontAwesomeIcons.plus),
                              SizedBox(width: 15.0.w),
                              RoundIconButton(
                                  onPressed: () {
                                    setState(() {
                                      age--;
                                    });
                                  },
                                  icon: FontAwesomeIcons.minus)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          CalculateButton(
            label: 'CALCULATE',
            onPressed: () {
              CalculatorBrain calc =
                  CalculatorBrain(weight: weight, height: height);
              if (genderSelection()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultPage(
                      bmi: calc.calculateBMI(),
                      interpretation: calc.getInterpretation(),
                      result: calc.getResult(),
                    ),
                  ),
                );
              } else {
                showToast();
              }
            },
          )
        ],
      ),
    );
  }
}

void showToast() =>
    Fluttertoast.showToast(msg: 'Select Gender!', fontSize: 18.0);
