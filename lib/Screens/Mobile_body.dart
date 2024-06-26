import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import 'package:riveanimationapp/Authentication/validate.dart';

class MoBileBodyScreen extends StatefulWidget {
  const MoBileBodyScreen({Key? key}) : super(key: key);

  @override
  State<MoBileBodyScreen> createState() => _MoBileBodyScreenState();
}

class _MoBileBodyScreenState extends State<MoBileBodyScreen> {
  bool obscure = true;
  bool emailValid = false;
  bool passwordValid = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  StateMachineController? stateMachineController;
  SMIInput<bool>? isChecking;
  SMIInput<bool>? trigFail;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? isHandsUp;
  SMINumber? numLook;

  String errorMessageEmail = '';
  String errorMessagePassword = '';

  void isCheckingField() {
    isHandsUp?.change(false);
    isChecking?.change(true);
    numLook?.change(0);
  }

  void moveEyeBall(String value) {
    numLook?.change(value.length.toDouble());
  }

  void hidePassword(String value) {
    isHandsUp?.change(true);
  }

  bool isPasswordValid(String password) {
    return password.length >= 8 &&
        password.contains(RegExp(r'[A-Z]')) && // Uppercase letter
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')); // Symbol
  }

  @override
  Widget build(BuildContext context) {
    double aspectRatio = 16 / 9;
    double screenWidth = MediaQuery.of(context).size.width;
    double height = screenWidth / aspectRatio;

    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 1,
              color: Colors.blue.shade100,
              alignment: Alignment.center,
              width: double.infinity,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 0, left: 0, right: 0, bottom: 10),
                      child: Container(
                        height: height,
                        width: screenWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0)),
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: RiveAnimation.asset(
                            "assets/images/animated_login_character.riv",
                            stateMachines: const ["Login Machine"],
                            onInit: (artboard) {
                              final controller =
                                  StateMachineController.fromArtboard(
                                artboard,
                                "Login Machine",
                              );
                              if (controller != null) {
                                stateMachineController = controller;
                                artboard.addController(controller);
                                isChecking = stateMachineController
                                    ?.findInput<bool>("isChecking");
                                trigFail = stateMachineController
                                    ?.findInput<bool>("trigFail");
                                trigSuccess = stateMachineController
                                    ?.findInput<bool>("trigSuccess");
                                isHandsUp = stateMachineController
                                    ?.findInput<bool>("isHandsUp");
                                numLook = stateMachineController
                                    ?.findSMI<SMINumber>("numLook");
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Welcome back",
                      style: GoogleFonts.kanit(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              blurRadius: 0.45,
                              offset: Offset(0.5, 0.9),
                            )
                          ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      child: TextFormField(
                        onTap: isCheckingField,
                        onEditingComplete: () {
                          isChecking?.change(false);
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        controller: _username,
                        style: GoogleFonts.kanit(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        cursorColor: Colors.red,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "Username ",
                          labelText: "Username",
                          labelStyle: GoogleFonts.kanit(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                        ),
                        validator: (value) {
                          setState(() {
                            emailValid = AppRegex.isEmailValid(value ?? '');
                            if (emailValid) {
                              errorMessageEmail = '';
                            } else {
                              errorMessageEmail = 'Invalid email format';
                            }
                          });

                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      child: TextFormField(
                        onTap: () {
                          setState(() {
                            if (_password.text.isEmpty) {
                              isChecking?.change(true);
                            } else {
                              obscure = false;
                              isHandsUp?.change(true);
                            }
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            passwordValid = isPasswordValid(value);
                            obscure = false;
                            isHandsUp?.change(true);
                            if (passwordValid) {
                              errorMessagePassword = '';
                            } else {
                              errorMessagePassword =
                                  'Password must contain at least 8 characters, one uppercase letter, and one symbol.';
                            }
                          });
                        },
                        onEditingComplete: () {
                          isHandsUp?.change(false);
                          isChecking?.change(false);
                          FocusManager.instance.primaryFocus?.unfocus();
                          setState(() {
                            obscure = true;
                            isHandsUp?.change(false);
                          });
                        },
                        obscureText: obscure,
                        controller: _password,
                        style: GoogleFonts.kanit(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        cursorColor: Colors.red,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          labelText: "Password",
                          hintText: "Password",                          labelStyle: GoogleFonts.kanit(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscure ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                obscure = !obscure;
                                if (obscure == false) {
                                  isHandsUp?.change(true);
                                } else {
                                  isHandsUp?.change(false);
                                }
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          setState(() {
                            passwordValid = isPasswordValid(value ?? '');
                            if (passwordValid) {
                              errorMessagePassword = '';
                            }
                          });

                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      errorMessageEmail.isNotEmpty
                          ? errorMessageEmail
                          : (errorMessagePassword.isNotEmpty
                              ? errorMessagePassword
                              : ''),
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50, // Set the desired height
                      child: CupertinoButton(
                        color: Colors.blue.shade300,
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              emailValid &&
                              passwordValid) {
                            isHandsUp?.change(false);
                            isChecking?.change(false);
                            numLook?.change(0);
                            trigSuccess?.change(true);
                          } else {
                            trigFail?.change(true);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
