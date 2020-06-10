import 'package:flutter/material.dart';

class Test1 extends StatelessWidget {
  myfunc(int nb) {
    print(nb);
  }

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
              child: Text(
                "0",
                style: TextStyle( // Styling the text
                  fontSize: 50.0,
                  color: Colors.black
                ),
                textAlign: TextAlign.right,
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
                      _button("1", () => print("C")), // using custom widget _button
                      _button("2", () => print("0")),
                      _button("3", () => print("=")),              
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                      _button("4", () => print("C")), // using custom widget _button
                      _button("5", () => print("0")),
                      _button("6", () => print("=")),           
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                      _button("7", () => print("C")), // using custom widget _button
                      _button("8", () => print("0")),
                      _button("9", () => print("=")),           
                    ],
                  ),
                  _button("0", () => print("=")),    
                ]
              )
            )
          ],
      )
    );
  }

  Widget _button (String number, Function() f){ // Creating a method of return type Widget with number and function f as a parameter
    return MaterialButton(
      height: 100.0,
      child: Text(number,
      style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0)),
      textColor: Colors.black,
      color: Colors.grey[100],
      onPressed: f,
    );
  }
}