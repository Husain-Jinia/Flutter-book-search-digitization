import 'dart:developer';
import 'dart:io';

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
          const SizedBox(height: 15,),
          ElevatedButton(
            onPressed: () => pickImage(),
            child: Row(children: const [
              Icon(Icons.image),
              SizedBox(width: 5,),
              Text("Open image"),
            ],))
        ],
      )
    );
  }
}