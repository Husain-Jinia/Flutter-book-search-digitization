import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {

  TextEditingController searchController;

  SearchTextField({Key? key, required this.searchController}) : super(key: key);

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField( 
      controller: widget.searchController,
      decoration: InputDecoration(
        label: const Text("Search query"),
        hintText: "Enter the name of the book you want to find.",
        fillColor: Colors.grey[200],
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}