import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const FlutterApp());
}

class FlutterApp extends StatelessWidget {
  const FlutterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController controller = TextEditingController();
  int? randNumber;
  int? tstNumber;
  String btnText = 'Start';
  String youTried = '';
  String tryAgain = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Guess my number'),
        centerTitle: false,
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'I\'m thinking of a number between 1 and 100',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'It\'s your turn to guess my number!',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  youTried,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  tryAgain,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 300,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Text(
                          "Try a number!",
                          style: TextStyle(
                            fontSize: 35,
                            color: Color(0xFF6F6F75),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: const TextStyle(
                            fontSize: 20.0,
                          ),
                          controller: controller,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 15),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              if (int.parse(value!) is int) {
                                tstNumber = int.parse(value);
                              }
                            });
                          },
                        ),
                      ),
                      Container(
                        height: 5.0,
                        width: 250,
                        color: Colors.blue,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (controller.text.isNotEmpty &&
                                  btnText == 'Guess') {
                                youTried = 'You tried $tstNumber';
                                if (tstNumber! > randNumber!) {
                                  tryAgain = 'Try lower';
                                } else if (tstNumber! < randNumber!) {
                                  tryAgain = 'Try higher';
                                } else {
                                  tryAgain = 'You guessed right';
                                  btnText = 'Reset';
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: const Text("You guessed right"),
                                          content: Text("It was $tstNumber"),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'Cancel'),
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'OK'),
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ),
                                  );
                                  controller.clear();
                                }
                              } else if (btnText != 'Guess') {
                                randNumber = Random().nextInt(99) + 1;
                                btnText = 'Guess';
                                controller.clear();
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF6F6F75),
                          ),
                          child: Text(btnText),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
