import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  CognitoUser user;
  String message;

  ResultPage({required this.user, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Result'),
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Hoşgeldin " + user.username.toString()),
        ])));
  }
}
