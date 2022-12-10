import 'package:book_search_digitization/image_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_search_digitization/globals.dart' as globals;

class SearchTextField extends StatefulWidget {
  TextEditingController searchController;

  SearchTextField({Key? key, required this.searchController}) : super(key: key);

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 15,
        ),
        // Consumer<ImageNotifier>(builder: (context, notifier, child) {
        //   return notifier.isImageTaken
        //       ? Container(
        //           height: 200,
        //           width: 400,
        //           decoration: BoxDecoration(
        //               color: Colors.grey[200],
        //               borderRadius: BorderRadius.circular(10)),
        //           child: Image(image: AssetImage(globals.userImage!.image)),
        //         )
        //       : const SizedBox.shrink();
        // }),
        const SizedBox(
          height: 35,
        ),
        const Text(
          "Enter the name of the book you want to search",
          style: TextStyle(fontSize: 13),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: widget.searchController,
          decoration: InputDecoration(
            label: const Text("Search query"),
            // hintText: "Enter the name of the book you want to find.",
            fillColor: Colors.grey[200],
            filled: true,
          ),
          validator: (value) {
            if (widget.searchController.text.isEmpty) {
              return "search field cannot be empty";
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }
}
