import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riveanimationapp/Screens/Dimension.dart';

class ResponsiveLayoutScreen extends StatefulWidget {
  final Widget MobileBody;
  final Widget DesktopBody;
  ResponsiveLayoutScreen(
      {super.key, required this.MobileBody, required this.DesktopBody});

  @override
  State<ResponsiveLayoutScreen> createState() => _LoninScreenState();
}

class _LoninScreenState extends State<ResponsiveLayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > Dimension.mobileWidth) {
          return widget.DesktopBody;
        } else {
          return widget.MobileBody;
        }
      },
    );
  }
}
