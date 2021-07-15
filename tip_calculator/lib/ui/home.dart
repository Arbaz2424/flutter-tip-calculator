import 'package:flutter/material.dart';

int _tipPercentage = 0;
int _perPersonCount = 1;
double _billAmount = 0.0;

class tipcalculator extends StatefulWidget {
  const tipcalculator({Key? key}) : super(key: key);

  @override
  _tipcalculatorState createState() => _tipcalculatorState();
}

class _tipcalculatorState extends State<tipcalculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        color: Colors.white,
        alignment: Alignment.center,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: [
            Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("bill amount"),
                    Text(
                        "\$${calculateTotalPerPerson(_billAmount, _perPersonCount, _tipPercentage)}"),
                  ],
                )),
            Container(
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: Colors.grey, style: BorderStyle.solid),
                ),
                child: Column(
                  children: [
                    TextField(
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      style: TextStyle(color: Colors.grey),
                      decoration: InputDecoration(
                          prefix: Text(
                            "enter amount ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          prefixIcon: Icon(Icons.attach_money)),
                      onChanged: (String value) {
                        try {
                          _billAmount = double.parse(value);
                        } catch (exeption) {
                          _billAmount = 0.0;
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "split",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(
                                  () {
                                    if (_perPersonCount > 1) {
                                      _perPersonCount--;
                                    } else {
                                      //do nothing
                                    }
                                  },
                                );
                              },
                              child: Center(
                                child: Container(
                                    alignment: Alignment.center,
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.blue,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "-",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    )),
                              ),
                            ),
                            Text(
                              "$_perPersonCount",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _perPersonCount++;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.blue,
                                ),
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("tip"),
                        ),
                        Text(
                            "\$${calculateTotalTip(_billAmount, _perPersonCount, _tipPercentage)}")
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("$_tipPercentage\%"),
                        Slider(
                            min: 0,
                            max: 100,
                            divisions: 10,
                            value: _tipPercentage.toDouble(),
                            onChanged: (double newvalue) {
                              setState(() {
                                _tipPercentage = newvalue.round();
                              });
                            })
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  calculateTotalPerPerson(double billAmount, int splitBy, int tipPercentage) {
    var totalPerPerson =
        (calculateTotalTip(billAmount, splitBy, tipPercentage) + billAmount) /
            splitBy;
    return totalPerPerson;
  }

  calculateTotalTip(double billAmount, int splitBy, int tipPercentage) {
    double totalTip = 0.0;
    if (billAmount < 0 || billAmount.toString().isEmpty || billAmount == null) {
    } else {
      totalTip = (billAmount * tipPercentage) / 100;
    }
  }
}
