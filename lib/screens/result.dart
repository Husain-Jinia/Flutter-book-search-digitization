import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: SingleChildScrollView(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text("Suggestions"),
                
              ],
            )
        ),
      )
    );
  }
}