import 'dart:io';

import 'package:calculate_it/widgets/my_button.dart';
import 'package:calculate_it/widgets/my_textfield.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class CalculatePage extends StatefulWidget {
  const CalculatePage({Key? key}) : super(key: key);

  @override
  _CalculatePageState createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {
  int selectedFuntionId = -1;

  int typedNumber1 = -1;
  int typedNumber2 = -1;

  TextEditingController number1Controller = TextEditingController();
  TextEditingController number2Controller = TextEditingController();

  List<double> results = [];

  List<Map> functions = [
    {
      'id': 0,
      'title': 'Add',
      'icon': Icons.add,
    },
    {
      'id': 1,
      'title': 'Substract',
      'icon': Icons.remove,
    },
    {
      'id': 2,
      'title': 'Multiply',
      'icon': Icons.close,
    },
    {
      'id': 3,
      'title': 'Divide',
      'icon': Icons.expand_less,
    },
  ];

  void calculate(int id) {
    if (typedNumber1 == -1 || typedNumber2 == -1) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    late num result;

    if (id == 0) {
      result = typedNumber1 + typedNumber2;
    } else if (id == 1) {
      result = typedNumber1 - typedNumber2;
    } else if (id == 2) {
      result = typedNumber1 * typedNumber2;
    } else if (id == 3) {
      result = typedNumber1 / typedNumber2;
    }
    setState(() {
      if (results.length > 4) {
        results.removeAt(0);
      }
      results.add(result.toDouble());
      selectedFuntionId = -1;
    });
  }

  void clear() {
    selectedFuntionId = -1;
    typedNumber1 = 0;
    typedNumber2 = 0;
    number1Controller.clear();
    number2Controller.clear();
    results.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBody: true,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: height * 0.3,
            decoration: BoxDecoration(
              color: MyColors.grey,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 20,
                  spreadRadius: 0,
                  blurStyle: BlurStyle.outer,
                ),
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: results.isEmpty
                  ? const Text(
                      'No action has been selected yet.',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    )
                  : Container(
                      margin: Platform.isIOS ? const EdgeInsets.only(top: 35) : null,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: results
                            .map((e) => Text(
                                  removeDecimalZeroFormat(e),
                                  style: const TextStyle(color: Colors.white, decoration: TextDecoration.underline),
                                ))
                            .toList(),
                      ),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                buildTextfields(),
                for (var function in functions)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: buildFuntionTiles(function),
                  ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: buildButtons(height),
    );
  }

  Column buildTextfields() {
    return Column(
      children: [
        MyTextfield(
          controller: number1Controller,
          labelText: 'First Number',
          onChanged: (val) {
            setState(() {
              if (val.isNotEmpty) {
                typedNumber1 = int.parse(val);
              }
            });
          },
        ),
        const SizedBox(height: 20),
        MyTextfield(
          controller: number2Controller,
          labelText: 'Second Number',
          onChanged: (val) {
            setState(() {
              if (val.isNotEmpty) {
                typedNumber2 = int.parse(val);
              }
            });
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  SafeArea buildButtons(double height) {
    return SafeArea(
      child: SizedBox(
        height: height * 0.06,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: MyButton(
                title: 'Clear',
                onTap: clear,
              ),
            )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: MyButton(
                title: 'Calculate',
                onTap: selectedFuntionId == -1
                    ? null
                    : () {
                        calculate(selectedFuntionId);
                      },
              ),
            )),
          ],
        ),
      ),
    );
  }

  ListTile buildFuntionTiles(Map<dynamic, dynamic> function) {
    return ListTile(
      leading: Icon(function['icon'], color: Colors.white),
      trailing: Icon(selectedFuntionId == function['id'] ? Icons.radio_button_checked : Icons.radio_button_off_outlined, color: Colors.white),
      onTap: () {
        setState(() {
          selectedFuntionId = function['id'];
        });
      },
      title: Text(
        function['title'],
        style: const TextStyle(color: Colors.white),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: selectedFuntionId == function['id'] ? Colors.white : Colors.grey[700]!,
          width: selectedFuntionId == function['id'] ? 2 : 1,
        ),
      ),
    );
  }
}

String removeDecimalZeroFormat(double n) {
  return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
}
