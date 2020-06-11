import 'package:flutter/material.dart';
import 'dart:math';

class Test1 extends StatefulWidget {

  @override
  Test1State createState() => Test1State();
  
  
}

class Test1State extends State<Test1> {
  addNumber(String fullStrNb,String strNbToAdd) {
    setState(() {      
      String newNb = fullStrNb + strNbToAdd;
      _numberStringProposition = newNb;
    });
  }

  int _numberToFind = Random().nextInt(100);
  String _numberStringProposition = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(  
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[ // the column widget uses the children property
            Container( // Display Cont
              constraints: BoxConstraints.expand( // Cr
                height: 100
              ),
              alignment: Alignment.bottomRight, // Aligning the text to the bottom right of our display screen
              color: Colors.white, // Seting the background color of the container
              child: Center(
                child: Text(
                  '$_numberStringProposition',
                  style: TextStyle( // Styling the text
                    fontSize: 70.0,
                    color: Colors.black
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            Container(
              constraints: BoxConstraints.expand(
                height: MediaQuery.of(context).size.height/2
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[ 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                      _button("1", () => addNumber(_numberStringProposition, "1")), // using custom widget _button
                      _button("2", () => addNumber(_numberStringProposition, "2")),
                      _button("3", () => addNumber(_numberStringProposition, "3")),              
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                      _button("4", () => addNumber(_numberStringProposition, "4")), // using custom widget _button
                      _button("5", () => addNumber(_numberStringProposition, "5")),
                      _button("6", () => addNumber(_numberStringProposition, "6")),           
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                      _button("7", () => addNumber(_numberStringProposition, "7")), // using custom widget _button
                      _button("8", () => addNumber(_numberStringProposition, "8")),
                      _button("9", () => addNumber(_numberStringProposition, "9")),           
                    ],
                  ),
                  _button("0", () => addNumber(_numberStringProposition, "0")),    
                ]
              )
            )
          ],
      )
    );
  }

  Widget _button (String number, Function() f){ // Creating a method of return type Widget with number and function f as a parameter
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(180)
      ),
      height: 100.0,
      child: Text(number,
      style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0)),
      textColor: Colors.black,
      color: Colors.green[200],
      onPressed: f,
    );
  }
}