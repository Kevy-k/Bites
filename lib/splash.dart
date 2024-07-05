import 'package:bites/User/user_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        child: Stack(
          children: [
            Opacity(
              opacity: 0.5,
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Image.asset(
                    'lib/Assets/Images/Food-in-the-mood-iphone.jpg',
                    fit: BoxFit.cover),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Bites",
                  style: TextStyle(
                      color: Color.fromARGB(255, 191, 82, 43),
                      fontSize: 80,
                      fontWeight: FontWeight.bold),
                ).animate().fade().slideY(
                    duration: const Duration(seconds: 1), begin: 0.5, end: 1.5),
                const SizedBox(
                  height: 350,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      child: ElevatedButton(
                        style: const ButtonStyle(
                          overlayColor: MaterialStatePropertyAll(Colors.red),
                          backgroundColor: MaterialStatePropertyAll(
                              Color.fromARGB(255, 191, 82, 43)),
                          foregroundColor:
                              MaterialStatePropertyAll(Colors.black),
                        ),
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const UserLogin(showMessage: false,messageContent: "",))),
                        child: const Row(
                          children: [
                            Text(
                              "Get Started ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            Icon(Icons.arrow_circle_right)
                          ],
                        ),
                      ),
                    ),
                  ],
                )
                    .animate()
                    .fade(delay: const Duration(seconds: 1))
                    .shimmer(duration: const Duration(seconds: 2)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
