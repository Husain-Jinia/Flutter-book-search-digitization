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
        type:StepperType.horizontal,
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
          }
        },
        onStepTapped: (int index) {
          setState(() {
            _index = index;
          });
        },
        steps: <Step>[
          const Step(
            title: Text('Image'),
            content: ImageField(),
          ),
          Step(
            title: const Text('Search query'),
            content: Center(
              child: SearchTextField(searchController: controller,)
            ),
          ),
        ],
      )
    );
  }
}