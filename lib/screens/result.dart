import 'dart:ui';
import 'dart:convert';
import 'dart:typed_data';
import 'package:book_search_digitization/api/ml_service.dart';
import 'package:flutter/material.dart';
import 'package:book_search_digitization/globals.dart' as globals;
import '../Api/Suggestions.dart';
import '../sharedPreferences.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  List<dynamic> suggestedBooks = [];
  String? author;

  @override
  void initState() {
    super.initState();
  }

  getSuggestedBooks() async {
    SharedPreferencesService preference = SharedPreferencesService();
    String? searchQuery = await preference.getFromSharedPref('search-query');
    Map books = await bookSuggestionsApi(searchQuery);
    return books["docs"];
  }

  getAuthorsBooks() async {
    SharedPreferencesService preference = SharedPreferencesService();
    String? searchQuery = await preference.getFromSharedPref('search-query');
    Map books = await bookSuggestionsApi(searchQuery);
    String bookAuthor =
        books.isNotEmpty ? books["docs"][0]["author_name"][0] : List.empty();
    Map authors = await bookSuggestionsApi(bookAuthor);
    return authors.isNotEmpty ? authors["docs"] : List.empty();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Result Page"),
        ),
        body: Container(
          margin: const EdgeInsets.all(15),
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              FutureBuilder<String>(
                  future: MLService().getResults(globals.sessionId),
                  builder: (context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                          padding: const EdgeInsets.only(left: 5),
                          child: Image(
                              image:
                                  MemoryImage((base64Decode(snapshot.data!))))
                          // const Text(
                          //   "Results",
                          //   style: TextStyle(fontSize: 15),
                          // )
                          );
                    } else {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: Column(
                            children: const [
                              CircularProgressIndicator(),
                              Text("FETCHING RESULTS")
                            ],
                          ),
                        ),
                      );
                    }
                  }),
              const SizedBox(height: 10),
              const SizedBox(height: 20),
              Container(
                  padding: const EdgeInsets.only(left: 5),
                  child: const Text(
                    "Related books",
                    style: TextStyle(fontSize: 15),
                  )),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FutureBuilder(
                    future: getSuggestedBooks(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Row(
                            children:
                                List.generate(snapshot.data.length, (index) {
                          return Container(
                              width: 150,
                              height: 190,
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.only(top: 3),
                              decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(children: [
                                Container(
                                  width: 140,
                                  height: 150,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Center(
                                      child: Icon(
                                    Icons.book,
                                    size: 50,
                                    color: Colors.black54,
                                  )),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(2, 0, 2, 0),
                                    child: Text(
                                      snapshot.data[index]["title"],
                                      style: const TextStyle(fontSize: 11),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                    ))
                              ]));
                        }));
                      } else {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    }),
              ),
              const SizedBox(height: 20),
              Container(
                  padding: const EdgeInsets.only(left: 5),
                  child: const Text(
                    "More from the author",
                    style: TextStyle(fontSize: 15),
                  )),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FutureBuilder(
                    future: getAuthorsBooks(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Row(
                            children:
                                List.generate(snapshot.data.length, (index) {
                          return Container(
                              width: 150,
                              height: 190,
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.only(top: 3),
                              decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(children: [
                                Container(
                                  width: 140,
                                  height: 150,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Center(
                                      child: Icon(
                                    Icons.book,
                                    size: 50,
                                    color: Colors.black54,
                                  )),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(2, 0, 2, 0),
                                    child: Text(
                                      snapshot.data[index]["title"],
                                      style: const TextStyle(fontSize: 11),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                    ))
                              ]));
                        }));
                      } else {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    }),
              ),
            ],
          )),
        ));
  }
}
