import 'package:flutter/material.dart';

class DestopBodyScreen extends StatefulWidget {
  const DestopBodyScreen({Key? key}) : super(key: key);

  @override
  State<DestopBodyScreen> createState() => _DestopBodyScreenState();
}

class _DestopBodyScreenState extends State<DestopBodyScreen> {
  @override
  Widget build(BuildContext context) {
    double aspectRatio = 16 / 9;

    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // Calculate the height based on the aspect ratio
    double height = screenWidth / aspectRatio;

    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      appBar: AppBar(
        title: Text("Desktop Layout"),
      ),
      body: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: height, // Fixed height
                      ),
                      child: Container(
                        width: double.infinity, // Occupy full width
                        color: Colors.deepPurple[400],
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          color: Colors.deepPurple,
                          height: 120,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              width: 200,
              color: Colors.deepPurple[300],
            ),
          )
        ],
      ),
    );
  }
}
