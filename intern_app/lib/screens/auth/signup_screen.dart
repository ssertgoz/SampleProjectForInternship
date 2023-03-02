// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:intern_app/data/aws_cognito.dart';
import 'package:intern_app/screens/auth/confirmation_dialog.dart';
import 'package:intern_app/screens/auth/result_screen.dart';
import 'package:intern_app/screens/auth/webview.dart';

// ignore: must_be_immutable
class SignupPage extends StatelessWidget {
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();

  SignupPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kaydol'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 60),
              FlutterLogo(size: 100),
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: _buildTextField(
                  controller: email_controller,
                  label: 'Email',
                  hintText: 'example@example.com',
                  obscureText: false,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: _buildTextField(
                  controller: password_controller,
                  label: 'Password',
                  hintText: '********',
                  obscureText: true,
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  onPressed: () async {
                    var user = await AWSServices().creatInitialRecord(
                        email_controller.text, password_controller.text, true);

                    if (user != null) {
                      var result = await showDialog(
                        context: context,
                        builder: (context) => ConfirmationDialog(
                          user: user,
                        ),
                      );
                      if (result) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => ResultPage(
                                  user: user,
                                )));
                      }
                    }
                  },
                  child: const Text(
                    'Kaydol',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Text(
                "Veya",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: 300,
                child: GoogleAuthButton(
                  onPressed: () {
                    // Google girişi işlemleri burada yapılacak
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => WebViewScreen(
                              identityProvider: "Google",
                            )));
                  },
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: 300,
                child: FacebookAuthButton(
                  onPressed: () {
                    // Facebook girişi işlemleri burada yapılacak
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => WebViewScreen(
                              identityProvider: "Facebook",
                            )));
                  },
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
    required bool obscureText,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 5),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          ),
        ),
      ],
    );
  }
}
