import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';
import 'package:intern_app/data/aws_cognito.dart';

class ConfirmationDialog extends StatelessWidget {
  final TextEditingController _textFieldController = TextEditingController();
  CognitoUser user;
  ConfirmationDialog({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter Text'),
      content: TextField(
        controller: _textFieldController,
        decoration: InputDecoration(hintText: 'Enter text here'),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('OK'),
          onPressed: () async {
            // Do something with entered text
            String enteredText = _textFieldController.text;
            bool result = await AWSServices().confirmUser(enteredText, user);
            if (result) {
              Navigator.of(context).pop(result);
            } else {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                  "Hatalı Kod",
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.symmetric(vertical: 400, horizontal: 30),
                backgroundColor: Colors.redAccent,
                behavior: SnackBarBehavior.floating,
              ));
            }
          },
        ),
      ],
    );
  }
}
