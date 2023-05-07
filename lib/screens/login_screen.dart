import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/firebase_services.dart';
import 'bottom_bar_screen.dart';
import 'buyer_homescreen.dart';
import 'forgot_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.userType});
  final String userType;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey expansionTile = GlobalKey();
  bool _switchingSignInAndSignUp = true;

  final ValueNotifier<bool> _isLoading = ValueNotifier(false);

  final AuthService _authService = AuthService();

  final String _errorMessage = '';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phnController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  // Controller

  final linearGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromRGBO(23, 213, 255, 1),
      Color.fromRGBO(224, 26, 255, 0.9),
    ],
  );

  final buttonGradient =
      const LinearGradient(colors: [Color(0xff1A2980), Color(0xff26D0CE)]);

  @override
  void initState() {
    // initialize controller
    log(widget.userType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: BoxDecoration(gradient: linearGradient),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 55),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/cons.png",
                  height: 45,
                  width: 160,
                ),
                Image.asset(
                  "assets/images/est.png",
                  height: 25,
                  width: 120,
                ),
              ],
            ),
            const SizedBox(height: 50),
            Container(
              height: 531,
              width: double.maxFinite,
              margin: const EdgeInsets.symmetric(horizontal: 34),
              decoration: BoxDecoration(
                image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/bg.png')),
                borderRadius: BorderRadius.circular(35),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 50),

                  /// Sign in  &  Sign up Widget
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 47),
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              debugPrint('Sign in $_switchingSignInAndSignUp');
                              Future.delayed(Duration.zero, () {
                                setState(
                                    () => _switchingSignInAndSignUp = true);
                              });
                            },
                            child: Container(
                              height: 45,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              decoration: BoxDecoration(
                                  gradient: _switchingSignInAndSignUp == true
                                      ? buttonGradient
                                      : null,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontFamily: 'Sansita',
                                  fontSize: 16,
                                  color: _switchingSignInAndSignUp == true
                                      ? Colors.white
                                      : const Color.fromRGBO(48, 68, 253, 1),
                                  letterSpacing: 0.048,
                                  fontWeight: FontWeight.w600,
                                  height: 1.6,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Future.delayed(Duration.zero, () {
                                setState(
                                    () => _switchingSignInAndSignUp = false);
                              });
                              debugPrint('Sign up $_switchingSignInAndSignUp');
                            },
                            child: Container(
                              height: 45,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              decoration: BoxDecoration(
                                  gradient: _switchingSignInAndSignUp == false
                                      ? buttonGradient
                                      : null,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontFamily: 'Sansita',
                                  fontSize: 15,
                                  color: _switchingSignInAndSignUp == false
                                      ? Colors.white
                                      : const Color.fromRGBO(48, 68, 253, 1),
                                  letterSpacing: 0.048,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Name Field Widget
                  _switchingSignInAndSignUp == false
                      ? Padding(
                          padding: const EdgeInsets.only(
                            left: 40,
                            right: 40,
                            top: 10,
                          ),
                          child: TextField(
                            controller: _nameController,
                            keyboardType: TextInputType.name,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                hintText: 'Name',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Sansita',
                                )),
                          ),
                        )
                      : Container(),

                  /// Email Field Widget
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 40,
                      right: 40,
                      top: 10,
                    ),
                    child: TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Sansita',
                          )),
                    ),
                  ),

                  _switchingSignInAndSignUp == false
                      ? Padding(
                          padding: const EdgeInsets.only(
                            left: 40,
                            right: 40,
                            top: 10,
                          ),
                          child: TextField(
                            controller: _phnController,
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                hintText: 'Contact Number',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Sansita',
                                )),
                          ),
                        )
                      : Container(),

                  /// Password Field Widget
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 40,
                      right: 40,
                      top: 10,
                    ),
                    child: TextField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Sansita',
                          )),
                    ),
                  ),
                  _switchingSignInAndSignUp == false
                      ? Padding(
                          padding: const EdgeInsets.only(
                            left: 40,
                            right: 40,
                            top: 10,
                          ),
                          child: TextField(
                            controller: _confirmPassController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                hintText: 'Confirm Password',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Sansita',
                                )),
                          ),
                        )
                      : Container(),

                  _switchingSignInAndSignUp == true
                      ? Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => const ForgotPassword()),
                            ),
                            child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.only(right: 30),
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'Sansita',
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  //  height: 2.17,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),

                  /// Continue Button Widget
                  InkWell(
                    onTap: () {
                      _isLoading.value = true;
                      _switchingSignInAndSignUp == false
                          ? _authService
                              .createUserWithEmailAndPassword(
                              _emailController.text.trim(),
                              _passwordController.text.trim(),
                              name: _nameController.text.trim(),
                              mobile: _phnController.text.trim(),
                              address: 'Pakistan',
                              userType: widget.userType,
                            )
                              .whenComplete(() {
                              _isLoading.value = false;
                              setState(() {
                                _switchingSignInAndSignUp = true;
                              });
                            })
                          : _authService
                              .signInWithEmailAndPassword(
                              _emailController.text.trim(),
                              _passwordController.text.trim(),
                              widget.userType,
                            )
                              .then((value) async {
                              if (value.user != null) {
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(value.user!.uid)
                                    .get()
                                    .then(
                                  (value) {
                                    log(value.data()!['userType']);
                                    if (value.exists &&
                                        value.data()!['userType'] ==
                                            widget.userType) {
                                      nextScreen(widget.userType == 'buyer'
                                          ? const BuyerHomeScreen()
                                          : const BottomBarScreen());
                                    } else {
                                      AuthService.signOut();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'You can\'t sign-in with ${widget.userType} account in ${widget.userType == 'buyer' ? 'seller dashboard' : 'buyer\'s dashboard'}'),
                                        ),
                                      );
                                    }
                                  },
                                );

                                _isLoading.value = false;
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('User not found'),
                                  ),
                                );
                                _isLoading.value = false;
                              }
                            }).catchError((error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(AuthService.msg.value),
                                ),
                              );
                              _isLoading.value = false;
                            });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 40,
                        right: 40,
                        top: 60,
                      ),
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                            gradient: buttonGradient,
                            color: Colors.blue,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: Center(
                          child: ValueListenableBuilder(
                            valueListenable: _isLoading,
                            builder: (BuildContext context, dynamic value,
                                Widget? child) {
                              return _switchingSignInAndSignUp == true
                                  ? _isLoading.value == true
                                      ? const CircularProgressIndicator()
                                      : const Text(
                                          'Login',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Sansita'),
                                          textAlign: TextAlign.center,
                                        )
                                  : _isLoading.value == true
                                      ? const CircularProgressIndicator()
                                      : const Text(
                                          'Sign Up',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Sansita'),
                                          textAlign: TextAlign.center,
                                        );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// Forgot Password Widget
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  // signUp() async {
  //   final email = _emailController.text.trim();
  //   final password = _passwordController.text.trim();
  //   if (email.isNotEmpty && password.isNotEmpty) {
  //     final user = await _authService.createUserWithEmailAndPassword(
  //       email,
  //       password,
  //       name: _nameController.text.trim(),
  //       address: _phnController.text.trim(),
  //     );
  //     if (user != null) {
  //       // ignore: use_build_context_synchronously
  //       Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(
  //             builder: (ctx) => const HomeScreen(),
  //           ),
  //           (route) => false);
  //     } else {
  //       setState(() {
  //         _errorMessage = 'Invalid email or password';
  //       });
  //     }
  //   } else {
  //     debugPrint('please provide the above details');
  //   }
  // }

  nextScreen(Widget screenName) {
    return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => screenName,
      ),
      (route) => false,
    );
  }
}
