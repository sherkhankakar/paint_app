import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _switchingSignInAndSignUp = true;

  final GlobalKey expansionTile = GlobalKey();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.maxFinite,
      decoration: BoxDecoration(gradient: linearGradient),
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
                image: AssetImage('assets/images/bg.png')
              ),
              borderRadius: BorderRadius.circular(35),
            ),
            child: Column(
              children: [
                const SizedBox(height: 90),

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
                              setState(() => _switchingSignInAndSignUp = true);
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
                              'SIGN IN',
                              style: TextStyle(
                                fontFamily: 'Sansita',
                                fontSize: 12,
                                color: _switchingSignInAndSignUp == true
                                    ? Colors.white
                                    : const Color(0xFF998FA2).withOpacity(0.6),
                                letterSpacing: 0.048,
                                fontWeight: FontWeight.w600,
                                height: 2.17,
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
                              setState(() => _switchingSignInAndSignUp = false);
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
                              'SIGN UP',
                              style: TextStyle(
                                fontFamily: 'Sansita',
                                fontSize: 12,
                                color: _switchingSignInAndSignUp == false
                                    ? Colors.white
                                    : const Color(0xFF998FA2).withOpacity(0.6),
                                letterSpacing: 0.048,
                                fontWeight: FontWeight.w600,
                                height: 2.17,
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
                          decoration: const InputDecoration(hintText: 'Name',hintStyle: TextStyle(fontFamily: 'Sansita',)),
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
                    decoration: const InputDecoration(hintText: 'Email',hintStyle: TextStyle(fontFamily: 'Sansita',)),
                  ),
                ),

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
                    decoration: const InputDecoration(hintText: 'Password',hintStyle: TextStyle(fontFamily: 'Sansita',)),
                  ),
                ),

                /// Continue Button Widget
                Padding(
                  padding: const EdgeInsets.only(
                    left: 40,
                    right: 40,
                    top: 60,
                  ),
                  child: InkWell(
                    // onTap: () => Navigator.push(
                    //   context,
                    //   PageTransition(
                    //     type: PageTransitionType.rightToLeft,
                    //     //duration: Duration(seconds: 1),
                    //     child: VerificationCode(),
                    //     curve: Curves.easeInOut,
                    //   ),
                    // ),
                    // onTap: () => appCredentials(context),
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: buttonGradient,
                          color: Colors.blue,
                          borderRadius: const BorderRadius.all(Radius.circular(30))),
                      child: const Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Sansita'),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),

                /// Forgot Password Widget
                _switchingSignInAndSignUp == true
                    ? Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          // onTap: () => Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //       builder: (_) => const ForgotPassword()),
                          // ),
                          child: Container(
                            margin: const EdgeInsets.only(top: 30),
                            child: const Text(
                              'FORGOT PASSWORD',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF8A56AC),
                                letterSpacing: 0.048,
                                fontWeight: FontWeight.w600,
                                height: 2.17,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
