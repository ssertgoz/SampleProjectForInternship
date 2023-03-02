// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:intern_app/data/aws_cognito.dart';
import 'package:intern_app/screens/auth/result_screen.dart';
import 'package:intern_app/screens/auth/webview.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();

  LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giriş Yap'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 60),
              const FlutterLogo(size: 100),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: _buildTextField(
                  controller: email_controller,
                  label: 'Email',
                  hintText: 'example@example.com',
                  obscureText: false,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: _buildTextField(
                  controller: password_controller,
                  label: 'Password',
                  hintText: '********',
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  onPressed: () async {
                    var user = await AWSServices().creatInitialRecord(
                        email_controller.text, password_controller.text, false);
                    if (user != null) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => ResultPage(
                                user: user,
                              )));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          "Hatalı Kullanıcı",
                          textAlign: TextAlign.center,
                        ),
                        margin:
                            EdgeInsets.symmetric(vertical: 400, horizontal: 30),
                        backgroundColor: Colors.redAccent,
                        behavior: SnackBarBehavior.floating,
                      ));
                    }
                  },
                  child: const Text(
                    'Giriş Yap',
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
                  onPressed: () async {
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
