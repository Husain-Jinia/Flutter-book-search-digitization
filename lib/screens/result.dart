import 'package:flutter/material.dart';

import '../Api/Suggestions.dart';
import '../sharedPreferences.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  List<dynamic> suggestedBooks = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  getSuggestedBooks() async {
    SharedPreferencesService preference = SharedPreferencesService();
    String? searchQuery = await preference.getFromSharedPref('search-query');
    print(searchQuery);
    Map books = await bookSuggestionsApi(searchQuery);
    return books["docs"];
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
            child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15,),
                Container(
                  padding: EdgeInsets.only(left: 5),
                  child: const Text("Results", style: TextStyle(fontSize: 15),)
                ),
                const SizedBox(height:10),
                Container(
                  height: 270,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
                const SizedBox(height:20),
                Container(
                  padding: const EdgeInsets.only(left: 5),
                  child: const Text("Suggestions", style: TextStyle(fontSize: 15),)
                ),
                const SizedBox(height: 10,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: FutureBuilder(
                    future:getSuggestedBooks(),
                    builder: (BuildContext context,
                        AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Row(children: List.generate(snapshot.data.length, (index){
                          return Container(
                            width: 150,
                            height: 190,
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.only(top:3),
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child:Column(
                              children:[
                                Container(width: 140,height: 150,
                                
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(5)
                                  
                                ),
                                child: Center(child: Icon(Icons.book, size: 50,color: Colors.black54,)),
                                ),
                                SizedBox(height: 5,),
                                Container(
                                  padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                                  child: Text(snapshot.data[index]["title"], style: const TextStyle(fontSize: 11),textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,))
                            ]));
                        }));
                      } else {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    }),
                ),
              ],
            )
        ),
      )
    );
  }
}