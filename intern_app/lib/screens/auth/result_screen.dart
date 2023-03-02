// ignore_for_file: prefer_const_constructors

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ResultPage extends StatelessWidget {
  CognitoUser user;

  ResultPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Result'),
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Hoşgeldin ${user.username}"),
        ])));
  }
}
