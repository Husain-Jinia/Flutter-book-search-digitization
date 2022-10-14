import 'package:book_search_digitization/screens/result.dart';
import 'package:book_search_digitization/widgets/image_field.dart';
import 'package:book_search_digitization/widgets/search_text_form.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _index = 0;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page"),
      ),
      body: Stepper(
        type:StepperType.vertical,
        currentStep: _index,
        onStepCancel: () {
          if (_index > 0) {
            setState(() {
              _index -= 1;
            });
          }
        },
        onStepContinue: () {
          if (_index <= 0) {
            setState(() {
              _index += 1;
            });
          }else{
            Navigator.push(
            context,
                MaterialPageRoute(
                builder: (BuildContext context) => const ResultPage(),
              )
            );
          }
        },
        onStepTapped: (int index) {
          setState(() {
            _index = index;
          });
        },
        steps: <Step>[
          const Step(
            title: Text('Image Selection'),
            content: ImageField(),
          ),
          Step(
            title: const Text('Search Query'),
            content: Center(
              child: SearchTextField(searchController: controller,)
            ),
          ),
        ],
      )
    );
  }
}