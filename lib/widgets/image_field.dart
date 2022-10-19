import 'dart:developer';
import 'dart:io';

import 'package:book_search_digitization/models/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';



class ImageField extends StatefulWidget {
  const ImageField({Key? key}) : super(key: key);

  @override
  State<ImageField> createState() => _ImageFieldState();
}

class _ImageFieldState extends State<ImageField> {

  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null ) {
        return;
      }
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      log("Failed to pick image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 30,),
          image!=null?
          Image.file(
            image!,
            width: 350,
            height: 200,
            fit:BoxFit.contain
          ): const Image(image: AssetImage('assets/bg_image.png'),             
            width: 250,
            height: 250,),
          const SizedBox(height: 15,),
          ElevatedButton(
            onPressed: () => pickImage(),
            style: ElevatedButton.styleFrom(
              primary: Colors.brown[400]
            ),
            child: Row(
              children: const [
              Icon(Icons.camera),
              SizedBox(width: 10,),
              Text("Open camera"),
            ],))
        ],
      )
    );
  }
}