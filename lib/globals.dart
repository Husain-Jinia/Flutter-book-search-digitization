import 'package:book_search_digitization/models/image_model.dart';

ImageModel? _userImage;
var _sessionId;

ImageModel? get userImage => _userImage;
set userImage(ImageModel? image) {
  _userImage = image;
}

dynamic get sessionId => _sessionId;
set sessionId(id) {
  _sessionId = id;
}
