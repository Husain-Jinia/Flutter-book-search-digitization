import 'package:flutter/cupertino.dart';

class ImageNotifier extends ChangeNotifier {
  bool _isImageTaken = false;
  get isImageTaken => _isImageTaken;
  void toggleImageAvailability(bool imageAvailability) {
    _isImageTaken = imageAvailability;
    notifyListeners();
  }
}
