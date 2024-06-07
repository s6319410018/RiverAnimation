import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:riveanimationapp/Authentication/validate.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1,
                  ),
                  height: MediaQuery.of(context).size.height * 0.3,
                  color: Colors.blue.shade100,
                  alignment: Alignment.center,
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: RiveAnimation.asset(
                      "assets/images/animated_login_character.riv",
                      stateMachines: const ["Login Machine"],
                      onInit: (artboard) {
                        final controller = StateMachineController.fromArtboard(
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
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  color: Colors.blue.shade100,
                  alignment: Alignment.center,
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            onTap: isCheckingField,
                            onEditingComplete: () {
                              isChecking?.change(false);
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            controller: _username,
                            style: const TextStyle(fontSize: 15),
                            cursorColor: Colors.red,
                            decoration: InputDecoration(
                              hintText: "Username",
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
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
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
                            style: const TextStyle(fontSize: 15),
                            cursorColor: Colors.red,
                            decoration: InputDecoration(
                              hintText: "Password",
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
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
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
                          SizedBox(
                            height: 5,
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
                          CupertinoButton(
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
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 300,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
