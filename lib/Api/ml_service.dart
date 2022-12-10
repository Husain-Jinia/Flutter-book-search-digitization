import 'dart:ui';
import 'dart:convert';
import 'dart:typed_data';
import 'package:book_search_digitization/models/image_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:book_search_digitization/globals.dart' as globals;

class MLService {
  Future<dynamic> uploadImage(ImageModel? image) async {
    MultipartFile file = await MultipartFile.fromFile(image!.image);
    var formData = FormData.fromMap({'file': file});
    var response =
        await Dio().post('http://10.0.2.2:8000/uploadfile/', data: formData);
    globals.sessionId = response.data['sessionId'];
  }

  Future<String> getResults(sessionId) async {
    //var formData = FormData.fromMap({'sessionId': sessionId});
    var response = await Dio().post(
      'http://10.0.2.2:8000/result/' + '$sessionId',
    ); //data: formData);
    var resultImage = response.data["result"];
    //Image(image: MemoryImage(base64Decode(response.data)));
    return resultImage;
  }
}
