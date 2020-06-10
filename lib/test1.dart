import 'package:flutter/material.dart';

class Test1 extends StatelessWidget {
  myfunc(int nb) {
    print(nb);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: FlatButton(
            onPressed: (() => print("a")),
            color: Colors.red,
            child: Text(
              "a"
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0)
            ),
          ),
          // child: GridView.count(
          //   primary: false,
          //   padding: const EdgeInsets.all(20),
          //   crossAxisSpacing: 10,
          //   mainAxisSpacing: 10,
          //   crossAxisCount: 3,
          //   children: List.generate(9, (index) {
          //     return FlatButton(
          //         onPressed: (() => print(index)),
          //         color: Colors.red,
          //         child: Text(
          //           '$index'
          //         ),
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(18.0),
          //           side: BorderSide(color: Colors.red)
          //         ),
          //       );
          //   }),
            // children: <Widget>[
            //   Container(
            //     padding: const EdgeInsets.all(8),
            //     child: FlatButton(
            //       onPressed: (() => print(1)),
            //       color: Colors.red,
            //       child: Text(
            //         "1"
            //       ),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(18.0),
            //         side: BorderSide(color: Colors.red)
            //       ),
            //     ),
            //   ),
            // ],
          // )
        )
      )
    );
  }
}