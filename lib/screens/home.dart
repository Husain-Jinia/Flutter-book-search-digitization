import 'package:book_search_digitization/api/ml_service.dart';
import 'package:book_search_digitization/image_notifier.dart';
import 'package:book_search_digitization/screens/result.dart';
import 'package:book_search_digitization/widgets/image_field.dart';
import 'package:book_search_digitization/widgets/search_text_form.dart';
import 'package:flutter/material.dart';
import 'package:book_search_digitization/globals.dart' as globals;
import 'package:provider/provider.dart';
import '../sharedPreferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  TextEditingController controller = TextEditingController();

  persistSearchQuery() async {
    SharedPreferencesService preference = SharedPreferencesService();
    if (controller.text.isNotEmpty) {
      await preference.saveToSharedPref('search-query', controller.text);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return 
    // Consumer<ImageNotifier>(
    //   builder: (context, notifier, child) => 
      Scaffold(
          appBar: AppBar(
            title: const Text("Home page"),
          ),
          body: Stepper(
            type: StepperType.horizontal,
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
                MLService().uploadImage(globals.userImage);
                // notifier.toggleImageAvailability(true);
              } else {
                if (controller.text.isNotEmpty) {
                  persistSearchQuery();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const ResultPage(),
                      ));
                }
              }
            },
            onStepTapped: (int index) {
              setState(() {
                _index = index;
              });
            },
            steps: <Step>[
              Step(
                title: const Text('Image Selection'),
                isActive: _index >= 0,
                content: ImageField(),
              ),
              Step(
                title: const Text('Search Query'),
                isActive: _index >= 1,
                content: Center(
                    child: SearchTextField(searchController: controller)),
              ),
            ],
          )
          //),
    );
  }
}
