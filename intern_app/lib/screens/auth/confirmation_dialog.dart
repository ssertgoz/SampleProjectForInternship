import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';
import 'package:intern_app/data/aws_cognito.dart';

// ignore: must_be_immutable
class ConfirmationDialog extends StatelessWidget {
  final TextEditingController _textFieldController = TextEditingController();
  CognitoUser user;
  ConfirmationDialog({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Onay Kodu'),
      content: TextField(
        controller: _textFieldController,
        decoration: const InputDecoration(hintText: 'Kodu buraya giriniz'),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Vazgeç'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Tamam'),
          onPressed: () async {
            // Do something with entered text
            String enteredText = _textFieldController.text;
            bool result = await AWSServices().confirmUser(enteredText, user);
            if (result) {
              // ignore: use_build_context_synchronously
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
