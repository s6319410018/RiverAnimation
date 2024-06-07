import 'package:flutter/material.dart';
import 'package:riveanimationapp/Screens/Destop_body.dart';
import 'package:riveanimationapp/Screens/Mobile_body.dart';
import 'package:riveanimationapp/Screens/Responsive_layout.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayoutScreen(
          MobileBody: MoBileBodyScreen(), DesktopBody: DestopBodyScreen()),
    );
  }
}
