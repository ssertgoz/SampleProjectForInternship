import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AWSServices {
  final userPool =
      CognitoUserPool('${dotenv.env['POOL_ID']}', '${dotenv.env['CLIENT_ID']}');

  Future creatInitialRecord(email, password, bool isSignUp) async {
    debugPrint("Authenticating...");
    final cognitoUser = CognitoUser(email, userPool);
    final authDetails = AuthenticationDetails(
      username: email,
      password: password,
    );
    final userAttributes = [
      AttributeArg(name: 'email', value: email),
    ];

    CognitoUserSession? session;

    try {
      if (isSignUp) {
        userPool.signUp(email, password, userAttributes: userAttributes);
      } else {
        session = await cognitoUser.authenticateUser(authDetails);
      }

      return cognitoUser;
    } on CognitoUserNewPasswordRequiredException catch (e) {
      debugPrint(e.toString());
    } on CognitoUserMfaRequiredException catch (e) {
      // handle SMS_MFA challenge
      debugPrint(e.toString());
    } on CognitoUserSelectMfaTypeException catch (e) {
      // handle SELECT_MFA_TYPE Challenge
      debugPrint(e.toString());
    } on CognitoUserMfaSetupException catch (e) {
      // handle MFA_SETUP challenge
      debugPrint(e.toString());
    } on CognitoUserTotpRequiredException catch (e) {
      // handle SOFTWARE_TOKEN_MFA challenge
      debugPrint(e.toString());
    } on CognitoUserCustomChallengeException catch (e) {
      // handle CUSTOM_CHALLENGE challenge
      debugPrint(e.toString());
    } on CognitoUserConfirmationNecessaryException catch (e) {
      // handle User Confirmation Necessary
      debugPrint(e.toString());
    } on CognitoClientException catch (e) {
      // handle Wrong Username and Password and Cognito Client
      debugPrint(e.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future confirmUser(String confirmationCode, CognitoUser user) async {
    bool result = await user.confirmRegistration(confirmationCode);
    return result;
  }

  Future signUserInWithAuthCode(String authCode) async {
    try {
      // ignore: prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings
      String url = "https://${dotenv.env['COGNITO_POOL_URL']}" +
          ".amazoncognito.com/oauth2/token?grant_type=authorization_code&client_id=" +
          "${dotenv.env['CLIENT_ID']}&client_secret=${dotenv.env['CLIENT_SECRET']}&code=" +
          authCode +
          "&redirect_uri=myapp://";
      final response = await http.post(Uri.parse(url),
          body: {},
          headers: {'Content-Type': 'application/x-www-form-urlencoded'});
      if (response.statusCode != 200) {
        throw Exception(
            "Received bad status code from Cognito for auth code:${response.statusCode}; body: ${response.body}");
      }

      final tokenData = json.decode(response.body);

      final idToken = CognitoIdToken(tokenData['id_token']);
      final accessToken = CognitoAccessToken(tokenData['access_token']);
      final refreshToken = CognitoRefreshToken(tokenData['refresh_token']);
      final session =
          CognitoUserSession(idToken, accessToken, refreshToken: refreshToken);
      final user = CognitoUser(null, userPool, signInUserSession: session);
      // NOTE: in order to get the email from the list of user attributes, make sure you select email in the list of
      // attributes in Cognito and map it to the email field in the identity provider.
      final attributes = await user.getUserAttributes();
      if (attributes != null) {
        for (CognitoUserAttribute attribute in attributes) {
          if (attribute.getName() == "email") {
            user.username = attribute.getValue();
            break;
          }
        }
      }

      return user;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
