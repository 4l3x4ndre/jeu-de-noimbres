import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hexcolor/hexcolor.dart';
import './test1.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => MyHomePage()
      },
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Potra'),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      //home: TutorialHome(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getAttemps());
  }

  List<String> gameDifficultyName = <String>[
    '0-10',
    '0-20',
    '0-50',
    '0-100',
    '0-500',
    '0-1000',
    '0-5000'
  ];
  List<int> gameDifficultyColor = <int>[100, 200, 300, 400, 500, 600, 700];
  List<String> _attemps = ["", "", "", "", "", "", ""];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Hexcolor('#141935'),
        // appBar: AppBar(
        //   title: Text(widget.title),
        // ),
        body: Center(
            // child: Test1()
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(30),
              child: Container(
                child: Text('Choose your level:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height / 30,
                        color: Colors.white)),
              ),
            ),
            ListView.separated(
              itemCount: gameDifficultyName.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Center(
                      child: ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width * 0.75,
                          height: MediaQuery.of(context).size.height / 20,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(180),
                                  topRight: Radius.circular(180),
                                  bottomLeft: Radius.circular(180),
                                  bottomRight: Radius.circular(180)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 0,
                                  blurRadius: 20,
                                  offset: Offset(
                                      0, 5), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).size.height / 80),
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(180)),
                                child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text('${gameDifficultyName[index]}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  30,
                                              color: Colors.black)),
                                      Text(
                                          'Best score: ' + '${_attemps[index]}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  40,
                                              color: Colors.black)),
                                    ]),
                                textColor: Colors.black,
                                color:
                                    Colors.indigo[gameDifficultyColor[index]],
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Test1(
                                            level: index,
                                            updateScoresHomeScreen: _getAttemps,
                                            levelColor: Colors.indigo[
                                                gameDifficultyColor[index]],
                                            maxNumber: int.parse(
                                                gameDifficultyName[index]
                                                    .split('-')[1]),
                                            levelNumbers:
                                                gameDifficultyName[index])),
                                  );
                                },
                              ),
                            ),
                          ))),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              shrinkWrap: true,
            ),
          ],
        )));
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
}
