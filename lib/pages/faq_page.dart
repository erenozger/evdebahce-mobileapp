import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FAQPage extends StatefulWidget {
  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  int _selectedOption = -1;
  Future<List<Question>> _getQuestions() async {
    var data = await http
        .get("http://www.json-generator.com/api/json/get/cemknnfHOq?indent=2");
    var jsonData = json.decode(data.body);

    List<Question> questions = [];
    for (var u in jsonData) {
      Question question = Question(u["index"], u["question"], u["answer"]);
      questions.add(question);
    }

    return questions;
  }

  Widget _questionsWidget() {
    return Container(
      child: FutureBuilder(
        future: _getQuestions(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: Text("Loading..."),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: _selectedOption == index - 1
                            ? Border.all(color: Colors.black26)
                            : null,
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                        child: Column(
                          children: [
                            Card(
                              shadowColor: Colors.grey[700],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              color: Colors.grey[200],
                              elevation: 20.0,
                              child: Container(
                                child: ListTile(
                                  leading: Icon(
                                    (Icons.live_help),
                                    size: 35,
                                  ),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          snapshot.data[index].question,
                                          style: TextStyle(
                                            fontSize: 13.0,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Icon(Icons.arrow_downward),
                                    ],
                                  ),
                                  selected: _selectedOption == index - 1,
                                  onTap: () {
                                    setState(() {
                                      _selectedOption = index - 1;
                                    });
                                  },
                                ),
                              ),
                            ),
                            _answerWidget(snapshot.data[index].answer,
                                _selectedOption, snapshot.data[index].index),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _answerWidget(String answer, int selected, int takenIndex) {
    if (selected + 1 != takenIndex) {
      return Card();
    } else if (selected + 1 == takenIndex) {
      return Card(
        semanticContainer: true,
        shadowColor: Colors.blue[400],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: Colors.blue[400],
        elevation: 20.0,
        child: ListTile(
          leading: Icon(
            (Icons.forward),
            size: 35.0,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Text(
                  answer,
                  style: TextStyle(color: Colors.white, fontSize: 13.0),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Text(
            "FAQ",
            style: TextStyle(
                color: Colors.grey[800],
                fontSize: 20,
                fontFamily: 'Noteworthy',
                fontWeight: FontWeight.bold),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey[100],
              backgroundImage: ExactAssetImage('assets/images/one.png'),
            ),
          )
        ],
      ),
      body: _questionsWidget(),
    );
  }
}

class Question {
  final int index;
  final String question;
  final String answer;

  Question(this.index, this.question, this.answer);
}
