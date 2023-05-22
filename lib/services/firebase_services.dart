import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static ValueNotifier msg = ValueNotifier('');
  static const apiKey = 'AIzaSyCrQM3WFg8FbAMmdbi163CLs6bic8sEoyc';
  static const baseUrl = 'https://fir-task-bac82-default-rtdb.firebaseio.com/';

  static SharedPreferences? prefs;

  // Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
    String userType,
  ) async {
    prefs = await SharedPreferences.getInstance();
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        final data = await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        prefs!.setString('email', userCredential.user!.email!);
        prefs!.setString('userType', userType);
        prefs!.setString('uid', userCredential.user!.uid.toString());
        prefs!.setString('phone', data.get('phone_number'));
        print(data.get('phone_number'));
      }
      print(userCredential.user);
      return userCredential;
    } catch (e) {
      // Handle sign-in error
      if (e is FirebaseAuthException) {
        if (e.code == 'wrong-password') {
          // Invalid password
          // Handle the error message or take appropriate action
          print('Invalid password. Please try again.');
          msg.value = 'Invalid password. Please try again.';
          throw Exception('Invalid password. Please try again.');
        } else {
          // Other FirebaseAuthException errors
          // Handle them based on the error code or take appropriate action
          print('Error occurred: ${e.code}');
        }
      } else {
        // Other types of exceptions
        // Handle them accordingly
        print('Error occurred: $e');
      }
      throw Exception(e);
    }
    // try {
    //   final url = Uri.parse(
    //       'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$apiKey');
    //   final response = await http.post(
    //     url,
    //     body: jsonEncode(
    //       {
    //         'email': email,
    //         'password': password,
    //         'returnSecureToken': true,
    //       },
    //     ),
    //   );
    //   final data = jsonDecode(response.body) as Map<String, dynamic>;
    //   if (response.statusCode == 200) {
    //     log(response.body);
    //     final prefs = await SharedPreferences.getInstance();
    //     prefs.setString('token', data['idToken'].toString());
    //     prefs.setString('email', data['email']);
    //     prefs.setString('uid', data['localId']);
    //     return response.statusCode;
    //   } else {
    //     log(response.statusCode.toString());
    //     return response.statusCode;
    //   }
    // } catch (e) {
    //   print(e.toString());
    //   throw Exception('User not found');
    // }
  }

  // Sign up with email and password
  Future<dynamic> createUserWithEmailAndPassword(String email, String password,
      {String? name, String? address, String? mobile, String? userType}) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        // Sign-up successful
        String userId = userCredential.user!.uid;

        // Call the createUserData method to create user data in Firestore
        createUserData(userId, name!, email, address!, mobile!, userType!);
      }
      return userCredential;
    } catch (e) {
      // Handle sign-up error
      print('Sign up error: $e');
      return null;
    }
    // try {
    //   final url = Uri.parse(
    //       'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$apiKey');
    //   final response = await http.post(url,
    //       body: jsonEncode({
    //         'email': email,
    //         'password': password,
    //         'returnSecureToken': true,
    //         'displayName': name,
    //         'mobile': mobile
    //       }));
    //   if (response.statusCode != 200) {
    //     log('Failed to set data: ${response.statusCode}');
    //   } else {
    //     log(response.body);
    //     final data = jsonDecode(response.body) as Map<String, dynamic>;
    //     final prefs = await SharedPreferences.getInstance();
    //     prefs.setString('token', data['idToken']);
    //     final userDetails = await http.post(
    //       Uri.parse(
    //           'https://fir-task-bac82-default-rtdb.firebaseio.com/users/${prefs.getString('email')}.json?auth=${data['idToken']}}'),
    //       body: jsonEncode(
    //         {
    //           'name': name,
    //           'email': email,
    //           'password': password,
    //           'address': address,
    //           'mobile': mobile,
    //           'userType': userType,
    //         },
    //       ),
    //     );
    //     log(userDetails.body);
    //     log(userDetails.statusCode.toString());
    //   }
    // } catch (e) {
    //   log(e.toString());
    //   return null;
    // }
  }

  void createUserData(
    String userId,
    String name,
    String email,
    String addres,
    String mobile,
    String userType,
  ) {
    _firestore.collection('users').doc(userId).set(
      {
        'name': name,
        'email': email,
        'address': addres,
        'phone_number': mobile,
        'userType': userType,
        'imageUploaded': false
      },
    );
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
  static Future<void> signOut() async {
    prefs = await SharedPreferences.getInstance();
    prefs!.clear();
    await _auth.signOut();
    // await googleSignIn.signOut();
  }

  // Get the current user
  Future<dynamic> getCurrentUser() async {
    log(_auth.currentUser.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        print('object: ${user.uid}\n $user');
      }

      final url = Uri.parse(
          'https://fir-task-bac82-default-rtdb.firebaseio.com/users.json?auth=${prefs.getString('token')}/&email=${prefs.getString('email')}');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        log(response.body);
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<DocumentSnapshot>> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('services').get();
      return querySnapshot.docs;
    } catch (e) {
      throw Exception(e);
    }
    // try {
    //   final url = Uri.parse(
    //     'https://fir-task-bac82-default-rtdb.firebaseio.com/services.json?auth=${prefs.getString('token')}',
    //   );
    //   final response = await http.get(url);
    //   log(response.body);
    //   if (response.statusCode == 200) {
    //     return jsonDecode(response.body) as Map<String, dynamic>;
    //   } else {
    //     return jsonDecode(response.body) as Map<String, dynamic>;
    //   }
    // } catch (e) {
    //   throw Exception(e);
    // }
  }

  Future<List<DocumentSnapshot>> fetchRequests() async {
    try {
      log('uid : ${FirebaseAuth.instance.currentUser!.uid}');
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('requests').get();
      return querySnapshot.docs;
    } catch (e) {
      throw Exception(e);
    }
  }

  DocumentSnapshot<Map<String, dynamic>>? _userData;
  DocumentSnapshot<Map<String, dynamic>>? get userData => _userData;
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    try {
      final data = await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      _userData = data;
      notifyListeners();
      return data;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> addService(Map<String, dynamic> data) async {
    try {
      final auth = FirebaseAuth.instance.currentUser;
      prefs = await SharedPreferences.getInstance();
      log(auth!.email!);

      _firestore.collection('services').doc().set({
        'name': data['name'],
        'location': data['location'],
        'description': data['description'],
        'paintQty': data['paintQty'],
        'paintCost': data['paintCost'],
        'labourQty': data['labourQty'],
        'labourCost': data['labourCost'],
        'wallQty': data['wallQty'],
        'wallCost': data['wallCost'],
        'doorQty': data['doorQty'],
        'doorCost': data['doorCost'],
        'windowQty': data['windowQty'],
        'windowCost': data['windowCost'],
        'brushQty': data['brushQty'],
        'brushCost': data['brushCost'],
        'tapeQty': data['tapeQty'],
        'tapeCost': data['tapeCost'],
        'wallCleanerQty': data['wallCleanerQty'],
        'wallCleanerCost': data['wallCleanerCost'],
        'seller_id': FirebaseAuth.instance.currentUser!.uid,
        'email': FirebaseAuth.instance.currentUser!.email,
        'service_type': prefs!.getString('userType'),
      }).then((value) {
        // Document successfully created
        msg.value = 'Added Successfully';
        print('Service document created successfully.');
      }).catchError((error) {
        // Error occurred while creating the document
        msg.value = 'Error:$error';
        print('Failed to create service document: $error');
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> sendRequest(Map<String, dynamic> data, String uid) async {
    prefs = await SharedPreferences.getInstance();
    try {
      _firestore.collection('requests').doc().set({
        'seller_id': uid,
        'email': prefs!.getString('email'),
        'phone': prefs!.getString('phone'),
        'paint_type': data['paint_type'],
        'coat': data['coat'],
        'wall_area': data['wall_area'],
        'door_area': data['door_area'],
        'window_area': data['window_area'],
        'paint_cost': data['paint_cost'],
      }).then((value) {
        msg.value = 'Success';
      }).catchError((error) {
        msg.value = 'Error:$error';
        print('Failed to create service document: $error');
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> deleteRequest(String docId) async {
    try {
      // Get a reference to the document you want to delete
      final docRef = _firestore.collection('requests').doc(docId);

      // Delete the document

      await docRef.delete().then((value) {}).catchError((e) {
        msg.value = e.toString();
      });
    } catch (e) {
      print('Error deleting document: $e');
      throw Exception(e);
    }
  }
}
