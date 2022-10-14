import 'package:http/http.dart' as http;

bookSuggestionsApi(book)async{
  var headersList = {
    'Accept': '*/*',
    'User-Agent': 'Thunder Client (https://www.thunderclient.com)' 
    };
    var url = Uri.parse('http://openlibrary.org/search.json?q=$book');

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
    }
    else {
      print(res.reasonPhrase);
  }
}