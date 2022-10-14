import 'package:book_search_digitization/sharedPreferences.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {

  TextEditingController searchController;

  SearchTextField({Key? key, required this.searchController}) : super(key: key);

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {

  persistSearchQuery()async {
    SharedPreferencesService preference = SharedPreferencesService();
    if(widget.searchController.text.isNotEmpty){
      await preference.saveToSharedPref('search-query', widget.searchController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return 
    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Enter the name of the book you want to search", style: TextStyle(fontSize: 13),),
        const SizedBox(height: 10,),
        TextFormField( 
          controller: widget.searchController,
          decoration: InputDecoration(
            label: const Text("Search query"),
            // hintText: "Enter the name of the book you want to find.",
            fillColor: Colors.grey[200],
            filled: true,
          ),
          validator: (value){
            if(widget.searchController.text.isEmpty){
              return "search field cannot be empty";
            }else{
              return null;
            }
          },
        ),
      ],
    );
  }
}