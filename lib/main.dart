import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//https://jsonplaceholder.typicode.com/posts
void main() async {
  // [{adlfasdfj;alfdal;fdjaldfja
  List _data = await getJSON();
  print(_data[1]["title"]);
  for (var i = 0; i < _data.length; i++) {
    print("Title: ${_data[i]["title"]}");
  }

  runApp(new MaterialApp(
    home: new Scaffold(
        appBar: AppBar(
          title: Text("JSON Parsing"),
          backgroundColor: Colors.orange,
        ),
        body: ListView.builder(
            itemCount: _data.length,
            padding: const EdgeInsets.all(4.4),
            itemBuilder: (BuildContext context, int position) {
              return Column(
                children: <Widget>[
                  Divider(
                    height: 3.4,
                  ),
                  ListTile(
                      title: Text(
                        _data[position]["title"],
                        style: TextStyle(
                            fontSize: 17.2, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(_data[position]["body"]),
                      //Paulo [P,a,u,l,o]
                      leading: CircleAvatar(
                        //radius: 45.6,
                        backgroundColor: Colors.orange,
                        child: Text(_data[position]["title"][0]),
                      ),
                      onTap: () =>
                          showTapMessage(context, _data[position]["title"]))
                ],
              );
            })),
  ));
}

void showTapMessage(BuildContext context, String message) {
  var alertDialog = new AlertDialog(
    title: Text(message),
    actions: <Widget>[
      FlatButton(
          onPressed: () => Navigator.of(context).pop(), child: Text("OK"))
    ],
  );
  showDialog(
      context: context,
      builder: (context) {
        return alertDialog;
      });
}

Future<List> getJSON() async {
  String apiUrl = "https://jsonplaceholder.typicode.com/posts";

  http.Response response = await http.get(apiUrl);

  return json.decode(response.body);
}
