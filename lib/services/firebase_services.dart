import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  static const apiKey = 'AIzaSyCrQM3WFg8FbAMmdbi163CLs6bic8sEoyc';
  static const baseUrl = 'https://fir-task-bac82-default-rtdb.firebaseio.com/';

  // Sign in with email and password
  Future<dynamic> signInWithEmailAndPassword(
    String email,
    String password,
    String userType,
  ) async {
    try {
      final url = Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$apiKey');
      final response = await http.post(
        url,
        body: jsonEncode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      if (response.statusCode == 200) {
        log(response.body);
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      print(e.toString());
      throw Exception('User not found');
    }
  }

  // Sign up with email and password
  Future<dynamic> createUserWithEmailAndPassword(String email, String password,
      {String? name, String? address, String? mobile, String? userType}) async {
    try {
      final url = Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$apiKey');
      final response = await http.post(url,
          body: jsonEncode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
            'displayName': name,
            'mobile': mobile
          }));

      if (response.statusCode != 200) {
        log('Failed to set data: ${response.statusCode}');
      } else {
        log(response.body);
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final userDetails = await http.post(
          Uri.parse(
              'https://fir-task-bac82-default-rtdb.firebaseio.com/users.json?auth=${data['idToken']}}'),
          body: jsonEncode(
            {
              'name': name,
              'email': email,
              'password': password,
              'address': address,
              'mobile': mobile,
              'userType': userType,
            },
          ),
        );
        log(userDetails.body);
        log(userDetails.statusCode.toString());
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // Sign in with Google
  // Future<User?> signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser!.authentication;
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //     UserCredential userCredential =
  //         await _auth.signInWithCredential(credential);
  //     return userCredential.user;
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
    // await googleSignIn.signOut();
  }

  // Get the current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
