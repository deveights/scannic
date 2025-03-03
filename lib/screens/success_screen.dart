import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: Lottie.asset('assets/animation/success.json'),
            ),
          ],
        ),
      ),
    );
  }
}
