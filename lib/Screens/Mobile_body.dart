import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

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
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                height: height,
                width: screenWidth,
                color: Colors.deepPurple[400],
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
                        trigFail =
                            stateMachineController?.findInput<bool>("trigFail");
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
            Container(
              height: 40,
              width: double.infinity,
              color: Colors.deepPurple,
              child: Text('data'),
            ),
            Container(
              height: 10,
              width: double.infinity,
              color: Colors.deepPurple,
              child: Text('data'),
            ),
          ],
        ),
      ),
    );
  }
}
