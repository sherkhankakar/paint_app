import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paint_app/screens/get_started_screen.dart';
import 'package:paint_app/services/firebase_services.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: kToolbarHeight + kToolbarHeight,
            ),
            const CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/images/male.jpg'),
            ),
            ListTile(
              title: const Text(
                'Username',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Text(
                userData.displayName ?? userData.email!,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              title: const Text(
                'Email',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Text(
                userData.email!,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              title: const Text(
                'Phone number',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Text(
                userData.phoneNumber ?? 'not given',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              title: const Text(
                'Last Sign in',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Text(
                userData.metadata.lastSignInTime!.toString().split(' ')[0],
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                AuthService.signOut().whenComplete(() => Navigator.of(context)
                    .pushAndRemoveUntil(
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
        ),
      ),
    );
  }
}
