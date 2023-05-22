import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paint_app/services/firebase_services.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:provider/provider.dart';

import '../components/text_field_component.dart';
import 'get_started_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final key = GlobalKey<FormState>();
  final ctr1 = TextEditingController();
  final ctr2 = TextEditingController();
  final ctr3 = TextEditingController();

  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;
  firebase_storage.Reference? _storageRef;
  File? _photoFile;
  String? _photoUrl;
  bool _uploading = false;
  double _uploadProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _storageRef = _storage
        .ref()
        .child('user_photos/${FirebaseAuth.instance.currentUser!.uid}');
  }

  Future<void> pickFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      setState(() {
        _photoFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _uploadPhoto() async {
    setState(() {
      _uploading = true;
      _uploadProgress = 0.0;
    });

    try {
      // Upload the photo to Firebase Storage
      String photoFileName = '${DateTime.now()}.png';
      firebase_storage.UploadTask uploadTask =
          _storageRef!.child(photoFileName).putFile(_photoFile!);

      // Listen to the upload task's stream for progress updates
      uploadTask.snapshotEvents
          .listen((firebase_storage.TaskSnapshot snapshot) {
        double progress = snapshot.bytesTransferred / snapshot.totalBytes;
        setState(() {
          _uploadProgress = progress;
        });
      });

      // Wait for the upload to complete
      await uploadTask.whenComplete(() async {
        // Get the download URL of the uploaded photo
        _photoUrl = await _storageRef!.child(photoFileName).getDownloadURL();
      });

      // Save the photo URL to Firestore
      if (_photoUrl != null) {
        // Update the user document with the photo URL
        String userId =
            FirebaseAuth.instance.currentUser!.uid; // Replace with your user ID
        FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({'photoUrl': _photoUrl, 'imageUploaded': true});
      }

      // Show success message or perform any other actions
      print('Photo uploaded successfully!');
    } catch (error) {
      // Handle errors
      print('Failed to upload photo: $error');
    } finally {
      setState(() {
        _uploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(110, 132, 255, 0.54),
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40))),
        centerTitle: true,
        toolbarHeight: 60,
        title: const Text(
          'Profile',
          style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
              fontFamily: 'Sansita',
              shadows: <Shadow>[
                Shadow(
                    offset: Offset(0, 2.0),
                    blurRadius: 5.0,
                    color: Colors.black54),
              ]),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: AlertDialog(
                      backgroundColor:
                          const Color.fromRGBO(23, 213, 255, 1).withGreen(155),
                      contentPadding: EdgeInsets.zero,
                      content: Container(
                        width: double.maxFinite,
                        height: MediaQuery.of(context).size.height * 0.5,
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromRGBO(23, 213, 255, 1),
                              Color.fromRGBO(224, 26, 255, 0.9),
                            ],
                          ),
                        ),
                        child: Form(
                          key: key,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextFieldComponent(
                                  ctr: ctr1,
                                  hint: provider.userData!.get('name'),
                                ),
                                const SizedBox(height: 15),
                                TextFieldComponent(
                                  ctr: ctr2,
                                  hint: provider.userData!.get('phone_number'),
                                ),
                                const SizedBox(height: 15),
                                TextFieldComponent(
                                  ctr: ctr3,
                                  hint: provider.userData!.get('address'),
                                ),
                                const SizedBox(height: 15),
                                TextButton(
                                  onPressed: pickFile,
                                  style: TextButton.styleFrom(
                                      foregroundColor: Colors.white),
                                  child: const Text('Pick Photo'),
                                ),
                                const SizedBox(height: 15),
                                _uploading
                                    ? CircularProgressIndicator(
                                        value: _uploadProgress,
                                        color: Colors.white,
                                      )
                                    : TextButton(
                                        onPressed: () {
                                          _uploadPhoto().whenComplete(() {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Photo uploaded successfully'),
                                              ),
                                            );
                                          });
                                        },
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                        ),
                                        child: const Text('Upload Photo'),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      actions: [
                        Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromRGBO(23, 213, 255, 1),
                              Color.fromRGBO(224, 26, 255, 0.9),
                            ],
                          )),
                          child: TextButton(
                            onPressed: () {
                              DocumentReference userRef = FirebaseFirestore
                                  .instance
                                  .collection('users')
                                  .doc(FirebaseAuth.instance.currentUser!.uid);

                              userRef.update({
                                'name': ctr1.text.isEmpty
                                    ? provider.userData!.get('name')
                                    : ctr1.text,
                                'phone_number': ctr2.text.isEmpty
                                    ? provider.userData!.get('phone_number')
                                    : ctr2.text,
                                'address': ctr3.text.isEmpty
                                    ? provider.userData!.get('address')
                                    : ctr3.text
                              }).then((value) async {
                                Navigator.of(context).pop();
                                setState(() {});
                              });
                            },
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.white),
                            child: const Text('Update'),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromRGBO(23, 213, 255, 1),
                              Color.fromRGBO(224, 26, 255, 0.9),
                            ],
                          )),
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: TextButton.styleFrom(
                                  foregroundColor: Colors.white),
                              child: const Text('Cancel')),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
      body: Container(
        height: double.maxFinite,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(23, 213, 255, 1),
            Color.fromRGBO(224, 26, 255, 0.9),
          ],
        )),
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: provider.getUserDetails(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: kToolbarHeight + kToolbarHeight,
                  ),
                  snapshot.data!.get('imageUploaded') == false
                      ? const CircleAvatar(
                          radius: 80,
                          backgroundImage: AssetImage('assets/images/male.jpg'),
                        )
                      : CircleAvatar(
                          radius: 80,
                          backgroundImage:
                              NetworkImage(snapshot.data!.get('photoUrl')),
                        ),
                  ListTile(
                    title: const Text(
                      'Username',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Text(
                      snapshot.data!.get('name'),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'Email',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Text(
                      snapshot.data!.get('email'),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'Address',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Text(
                      snapshot.data!.get('address'),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'Phone number',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Text(
                      snapshot.data!.get('phone_number') ?? 'not given',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      AuthService.signOut().whenComplete(() =>
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (ctx) => const GetStartedScreen()),
                              (route) => false));
                    },
                    child: const Text(
                      'Sign Out',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: kBottomNavigationBarHeight),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
