import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Widget calcButton(String btnText, Color btnColor, Color textColor) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          //Todo add function
          calculation(btnText);
        },
        child: Text(
          "$btnText",
          style: TextStyle(fontSize: 35, color: textColor),
        ),
        shape: CircleBorder(),
        color: btnColor,
        padding: EdgeInsets.all(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var nums = math.Random().nextInt(999);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(nums.toString()),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "$text",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white, fontSize: 100),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton("AC", Colors.white30, Colors.white),
                calcButton("+/-", Colors.white30, Colors.white),
                calcButton("%", Colors.white30, Colors.white),
                calcButton("/", Colors.amber, Colors.white)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton("7", Colors.grey, Colors.white),
                calcButton("8", Colors.grey, Colors.white),
                calcButton("9", Colors.grey, Colors.white),
                calcButton("×", Colors.amber, Colors.white)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton("6", Colors.grey, Colors.white),
                calcButton("5", Colors.grey, Colors.white),
                calcButton("4", Colors.grey, Colors.white),
                calcButton("-", Colors.amber, Colors.white)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton("3", Colors.grey, Colors.white),
                calcButton("2", Colors.grey, Colors.white),
                calcButton("1", Colors.grey, Colors.white),
                calcButton("+", Colors.amber, Colors.white)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  color: Colors.grey,
                  padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                  onPressed: () {
                    //Button function
                  },
                  shape: StadiumBorder(),
                  child: Text(
                    "0",
                    style: TextStyle(fontSize: 35, color: Colors.white),
                  ),
                ),
                calcButton(".", Colors.grey, Colors.white),
                calcButton("=", Colors.blue, Colors.white)
              ],
            )
          ],
        ),
      ),
    );
  }

  dynamic text = "0";
  dynamic numOne = 0;
  dynamic numTwo = 0;

  dynamic result = "";
  dynamic finalResult = "";
  dynamic opr = "";
  dynamic preOpr = "";

  void calculation(btnText) {
    if (btnText == "AC") {
      text = "0";
      numOne = 0;
      numTwo = 0;
      result = "";
      finalResult = "0";
      opr = "";
      preOpr = "";
    } else if (opr == "=" && btnText == "=") {
      if (preOpr == "+") {
        finalResult = add();
      } else if (preOpr == "-") {
        finalResult = sub();
      } else if (preOpr == "×") {
        finalResult = mul();
      } else if (preOpr == "/") {
        finalResult = div();
      }
    } else if (btnText == "+" ||
        btnText == "-" ||
        btnText == "×" ||
        btnText == "/" ||
        btnText == "=") {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (opr == "+") {
        finalResult = add();
      } else if (opr == "-") {
        finalResult = sub();
      } else if (opr == "×") {
        finalResult = mul();
      } else if (opr == "/") {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = "";
    } else if (btnText == "%") {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if (btnText == ".") {
      if (!result.toString().contains(".")) {
        result = result.toString() + ".";
      }
      finalResult = result;
    } else if (btnText == "+/-") {
      result.toString().startsWith("-")
          ? result = result.toString()
          : result = "-" + result.toString();
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains(".")) {
      List<String> splitDecimal = result.toString().split(".");
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}
