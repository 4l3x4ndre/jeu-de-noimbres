import 'package:app_test/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:math';

class Test1 extends StatefulWidget {
  final int level;
  final updateScoresHomeScreen;
  final levelColor;
  final int maxNumber;
  final String levelNumbers;

  const Test1(
      {Key key,
      this.level,
      this.updateScoresHomeScreen,
      this.levelColor,
      this.maxNumber,
      this.levelNumbers})
      : super(key: key);

  @override
  Test1State createState() => Test1State();
}

class Test1State extends State<Test1> {
  @override
  void initState() {
    print("e");
    _numberToFind = Random().nextInt(widget.maxNumber + 1);
    print(_numberToFind);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Hexcolor('#141935'),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Level: ' + widget.levelNumbers,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height / 20,
                      color: Colors.indigo[300] //Hexcolor('#546ae8')
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(180),
                            topRight: Radius.circular(180),
                            bottomLeft: Radius.circular(180),
                            bottomRight: Radius.circular(180)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.3),
                            spreadRadius: 10,
                            blurRadius: 20,
                            offset: Offset(0, 10), // changes position of shadow
                          ),
                        ]),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(180)),
                      height: MediaQuery.of(context).size.height / 10,
                      minWidth: MediaQuery.of(context).size.width / 5,
                      child: Icon(
                        Icons.home,
                        color: Hexcolor('#00a2d6'),
                        size: MediaQuery.of(context).size.height / 30,
                      ),
                      textColor: Colors.black,
                      color: Hexcolor('#90e1fd'), //Colors.lightBlue[700],
                      onPressed: () {
                        widget.updateScoresHomeScreen();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            constraints: BoxConstraints.expand(
                height: MediaQuery.of(context).size.height / 10),
            // color: Colors.white,
            alignment: Alignment.center,
            child: Center(
              child: Text(
                '$_numberStringProposition',
                style: TextStyle(
                    fontSize: 70.0,
                    color: Colors.indigo[300] //Hexcolor('#546ae8')
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
              constraints: BoxConstraints.expand(
                height: 75,
                width: MediaQuery.of(context).size.width * 0.7,
              ),
              alignment: Alignment.bottomRight,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$_tips',
                      style:
                          TextStyle(fontSize: 38.0, color: Colors.indigo[100]),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Attempts: " + '$_attempts',
                      style:
                          TextStyle(fontSize: 25.0, color: Colors.indigo[300]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )),
          Container(
              constraints: BoxConstraints.expand(
                  height: MediaQuery.of(context).size.height / 1.7),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _button(
                            "1",
                            () => addNumber(_numberStringProposition, "1"),
                            widget.levelColor),
                        _button(
                            "2",
                            () => addNumber(_numberStringProposition, "2"),
                            widget.levelColor),
                        _button(
                            "3",
                            () => addNumber(_numberStringProposition, "3"),
                            widget.levelColor),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _button(
                            "4",
                            () => addNumber(_numberStringProposition, "4"),
                            widget.levelColor),
                        _button(
                            "5",
                            () => addNumber(_numberStringProposition, "5"),
                            widget.levelColor),
                        _button(
                            "6",
                            () => addNumber(_numberStringProposition, "6"),
                            widget.levelColor),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _button(
                            "7",
                            () => addNumber(_numberStringProposition, "7"),
                            widget.levelColor),
                        _button(
                            "8",
                            () => addNumber(_numberStringProposition, "8"),
                            widget.levelColor),
                        _button(
                            "9",
                            () => addNumber(_numberStringProposition, "9"),
                            widget.levelColor),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _removeButton(widget.levelColor),
                        _button(
                            "0",
                            () => addNumber(_numberStringProposition, "0"),
                            widget.levelColor),
                        _validateButton(widget.level, widget.levelColor),
                      ],
                    ),
                  ]))
        ],
      )),
    );
  }

  Future<void> finish(level, nb) async {
    final prefs = await SharedPreferences.getInstance();
    final attempsStr = prefs.getStringList('attemps') ?? [];
    print("GOT THIS:" + attempsStr.toString());
    List<String> attempsTotal = [];
    bool win = false;
    for (var i = 0; i < 7; i++) {
      if (i < attempsStr.length - 1) {
        attempsTotal.add(attempsStr[i]);
      } else {
        attempsTotal.add("0");
      }
      if (i == level &&
          (attempsTotal[i] == "0" || nb < int.parse(attempsTotal[i]))) {
        win = true;
        attempsTotal[i] = nb.toString();
      }
    }
    print("ATTEMPS:" + attempsTotal.toString());
    prefs.setStringList('attemps', attempsTotal);
    getCurrentBestScore(level, nb);
    _getAttemps();
    _showVictory(win);
  }

  Future<void> getCurrentBestScore(level, nb) async {
    final prefs = await SharedPreferences.getInstance();
    final attempsStr = prefs.getStringList('attemps') ?? [];
    int _bs = 0;
    for (var i = 0; i < 7; i++) {
      if (i == level) {
        _bs = int.parse(attempsStr[i]);
      }
    }
    _bs = 0;
    setState(() {
      _bestScore = _bs;
    });
  }

  Future<void> _getAttemps() async {
    final prefs = await SharedPreferences.getInstance();
    final attempsStr = prefs.getStringList('attemps') ?? [];
    List<String> attempsTotal = [];
    for (var i = 0; i < 7; i++) {
      if (i < attempsStr.length - 1) {
        attempsTotal.add(attempsStr[i]);
      } else {
        attempsTotal.add("0");
      }
    }
    print(attempsTotal);
    setState(() {
      _attemps = attempsTotal;
    });
    print(_attemps);
  }

  addNumber(String fullStrNb, String strNbToAdd) {
    setState(() {
      String newNb = _hasValidate ? strNbToAdd : fullStrNb + strNbToAdd;
      _numberStringProposition = newNb;
    });
    _hasValidate = false;
  }

  validate(level) {
    print("validating number " +
        _numberToFind.toString() +
        " for level " +
        level.toString());
    _hasValidate = true;
    if (_numberStringProposition == "") return;
    String _t = "";
    if (_numberToFind == int.parse(_numberStringProposition)) {
      _t = "correct!";
      finish(level, _attempts + 1);
    } else if (_numberToFind > int.parse(_numberStringProposition)) {
      _t = "too small";
    } else {
      _t = "too hight";
    }
    setState(() {
      _tips = _t;
      _attempts = _attempts + 1;
    });
  }

  removeAction() {
    print("removing");
    if (_numberStringProposition.length == 0) return;
    String _s = _numberStringProposition.substring(
        0, _numberStringProposition.length - 1);
    setState(() {
      _numberStringProposition = _s;
    });
  }

  _showVictory(win) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              //height: MediaQuery.of(context).size.height / 2.2,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  color: Colors.indigoAccent,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
              child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(180.0),
                            child: _popupImage(win)
                            // Image.asset(
                            //   'assets/images/rocket_logo.png',
                            //   height: MediaQuery.of(context).size.width / 4,
                            //   width: MediaQuery.of(context).size.width / 4,
                            //   fit: BoxFit.fitHeight,
                            // ),
                            ),
                      ),
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12))),
                    ),
                    Container(
                        child: Column(children: <Widget>[
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        'you guessed it',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 11,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Attempts: " + '$_attempts',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 13,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Best: " + '${_attemps[widget.level]}',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 13,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // RaisedButton(
                          //   onPressed: () {
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) => MyHomePage()));
                          //   },
                          //   child: Icon(
                          //     Icons.check_circle_outline,
                          //     color: Colors.white,
                          //     size: MediaQuery.of(context).size.height / 30,
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(180)),
                              height: MediaQuery.of(context).size.height / 10,
                              minWidth: MediaQuery.of(context).size.width / 5,
                              textColor: Colors.white,
                              color: Colors.lightBlue,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyHomePage()));
                              },
                              child: Icon(
                                Icons.check_circle_outline,
                                color: Colors.white,
                                size: MediaQuery.of(context).size.height / 30,
                              ),
                            ),
                          ),
                        ],
                      )
                    ]))
                  ]),
            ));
      },
    );
  }

  _popupImage(win) {
    if (win) {
      return Image.asset(
        'assets/images/rocket_logo.png',
        height: MediaQuery.of(context).size.width / 4,
        width: MediaQuery.of(context).size.width / 4,
        fit: BoxFit.fitHeight,
      );
    } else {
      return Image.asset(
        'assets/images/rocket_down_logo.png',
        height: MediaQuery.of(context).size.width / 4,
        width: MediaQuery.of(context).size.width / 4,
        fit: BoxFit.fitHeight,
      );
    }
  }

  int _numberToFind;
  int _attempts = 0;
  String _numberStringProposition = "";
  String _tips = "";
  bool _hasValidate = false;
  int _bestScore = 0;
  List<String> _attemps = ["", "", "", "", "", "", ""];

  Widget _button(String number, Function() f, Color color) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(180),
                topRight: Radius.circular(180),
                bottomLeft: Radius.circular(180),
                bottomRight: Radius.circular(180)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.3),
                spreadRadius: 10,
                blurRadius: 20,
                offset: Offset(0, 10), // changes position of shadow
              ),
            ]),
        child: MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(180)),
            height: MediaQuery.of(context).size.height / 10,
            minWidth: MediaQuery.of(context).size.width / 5,
            textColor: Colors.white,
            color: Colors.indigo[500],
            onPressed: f,
            child: Text(number,
                style:
                    TextStyle(fontWeight: FontWeight.w100, fontSize: 38.0))));
  }

  Widget _validateButton(level, Color color) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(180),
              topRight: Radius.circular(180),
              bottomLeft: Radius.circular(180),
              bottomRight: Radius.circular(180)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.3),
              spreadRadius: 10,
              blurRadius: 20,
              offset: Offset(0, 10), // changes position of shadow
            ),
          ]),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(180)),
        height: MediaQuery.of(context).size.height / 10,
        minWidth: MediaQuery.of(context).size.width / 5,
        // minWidth: MediaQuery.of(context).size.width*0.50,
        child: Icon(
          Icons.check_circle_outline,
          color: Hexcolor('#2a5700'),
          size: MediaQuery.of(context).size.height / 30,
        ),
        color: Colors.lightGreen,
        onPressed: () => validate(level),
      ),
    );
  }

  Widget _removeButton(Color color) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(180),
              topRight: Radius.circular(180),
              bottomLeft: Radius.circular(180),
              bottomRight: Radius.circular(180)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.3),
              spreadRadius: 10,
              blurRadius: 20,
              offset: Offset(0, 10), // changes position of shadow
            ),
          ]),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(180)),
        height: MediaQuery.of(context).size.height / 10,
        minWidth: MediaQuery.of(context).size.width / 5,
        child: Icon(
          Icons.backspace,
          color: Hexcolor('#d68b9b'),
          size: MediaQuery.of(context).size.height / 30,
        ),
        color: Colors.pink[700],
        onPressed: removeAction,
      ),
    );
  }
}
