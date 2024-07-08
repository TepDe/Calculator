import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String symbol = "";
  String display = "";
  String total = "";
  String value = "";
  String value2 = "";

  void onOperation(String buttonText) {
    setState(() {
      if (total != "") {
        total = "";
        display = "";
      }
      if (buttonText == "÷" ||
          buttonText == "x" ||
          buttonText == "-" ||
          buttonText == "+" ||
          buttonText == "%") {
        display = "";
        symbol = buttonText;
        display = buttonText;
        if (value == "") {
          value = "0";
        }
      } else if (buttonText == "<-") {
        if (symbol == "") {
          value = value.length > 1 ? value.substring(0, value.length - 1) : "0";
          display = value;
        } else {
          value2 = value2.length > 1 ? value2.substring(0, value2.length - 1) : "0";
          display = value2;
        }
      } else if (buttonText == "=") {
        if (value2 == "") {
          total = value;
          symbol = "";
          value = "";
          value2 = "";
          display = total;
        } else {
          display = onCalculate(symbol);
        }
      } else if (buttonText == "C") {
        symbol = "";
        display = "";
        total = "";
        value = "";
        value2 = "";
      } else {
        if (symbol != "") {
          value2 += buttonText;
          display += buttonText;
        } else {
          value += buttonText;
          display += buttonText;
        }
      }
    });
  }

  String onCalculate(String buttonText) {
    double result = 0.0;
    double conValue = double.parse(value);
    double conValue2 = double.parse(value2);
    switch (buttonText) {
      case "÷":
        result = conValue2 != 0 ? conValue / conValue2 : double.nan;
        break;
      case "x":
        result = conValue * conValue2;
        break;
      case "-":
        result = conValue - conValue2;
        break;
      case "+":
        result = conValue + conValue2;
        break;
      case "%":
        double percentage = (conValue * conValue2) / 100;
        result = conValue - percentage;
        break;
      default:
        break;
    }
    // if (buttonText == "÷") {
    //   result = conValue2 != 0 ? conValue / conValue2 : double.nan;
    // } else if (buttonText == "*") {
    //   result = conValue * conValue2;
    // } else if (buttonText == "-") {
    //   result = conValue - conValue2;
    // } else if (buttonText == "+") {
    //   result = conValue + conValue2;
    // } else if (buttonText == "%") {
    //   double percentage = (conValue * conValue2) / 100;
    //   result = conValue - percentage;
    // }
    total = result.toString();
    if (result == result.roundToDouble()) {
      total = result.toInt().toString();
    } else {
      total = result.toStringAsFixed(2);
    }
    String history = "$value $symbol $value2 = $total";
    symbol = "";
    value = "";
    value2 = "";
    entries.add(history);
    return total;
  }

  final List<String> entries = <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            "History",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Text(
            "result ( ${entries.length} )",
            style: const TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 40,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(8),
                itemCount: entries.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text('${index + 1}./ ${entries[index]}   ');
                }),
          ),
          const Divider(),
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Text(
                display,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: <Widget>[
                reUseButton([".", "%", "<-"]),
                reUseButton(["7", "8", "9", "÷"]),
                reUseButton(["4", "5", "6", "x"]),
                reUseButton(["1", "2", "3", "-"]),
                reUseButton(["C", "0", "=", "+"]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget reUseButton(List<String> buttons) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons.map((buttonText) {
          return Expanded(
            child: OutlinedButton(
              onPressed: () => onOperation(buttonText),
              child: Text(
                buttonText,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
