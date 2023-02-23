import 'package:flutter/material.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intern_app/data/aws_cognito.dart';
import 'package:intern_app/screens/auth/result_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class WebViewScreen extends StatefulWidget {
  String identityProvider;

  WebViewScreen({super.key, required this.identityProvider});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool signedin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Webview'),
        ),
        body: getWebView(context));
  }

  Widget getWebView(context) {
    // ignore: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation
    var url =
        // ignore: prefer_interpolation_to_compose_strings
        "https://${dotenv.env['COGNITO_POOL_URL']}.amazoncognito.com/oauth2/authorize?identity_provider=${widget.identityProvider}&redirect_uri=" +
            "myapp://&response_type=CODE&client_id=${dotenv.env['CLIENT_ID']}" +
            "&scope=aws.cognito.signin.user.admin+email+openid+profile";

    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setUserAgent(
        'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) ' +
            'AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36',
      )
      ..setNavigationDelegate(
        NavigationDelegate(
            onProgress: (int progress) {
              debugPrint(progress.toString());
            },
            onPageStarted: (String url) {},
            onPageFinished: (String url) {},
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) async {
              debugPrint(request.url);
              if (!signedin &&
                  (request.url.startsWith("myapp:///?code=") ||
                      request.url.startsWith("myapp://?code="))) {
                String code = "";
                String message = "";
                if (request.url.startsWith("myapp:///?code=")) {
                  message = "Yeni giriş Yapıldı";
                  code = request.url.substring("myapp:///?code=".length);
                } else {
                  message = "Varolan Kullanıcı";
                  code = request.url.substring("myapp://?code=".length);
                }

                debugPrint(code);
                debugPrint("Geldiiii...");
                var result = await AWSServices().signUserInWithAuthCode(code);
                if ((result != null)) {
                  signedin = true;
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => ResultPage(
                            user: result,
                            message: message,
                          )));
                } else {
                  // ignore: prefer_const_constructors
                  setState(() {});
                }
                debugPrint("Başarılı...");
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            }),
      )
      ..loadRequest(Uri.parse(url));

    return WebViewWidget(controller: controller);
  }
}
