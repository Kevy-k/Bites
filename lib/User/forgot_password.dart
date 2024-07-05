import 'package:bites/User/user_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  final _emailController = TextEditingController();

  Future<void> sendResetPasswordLink(context) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const UserLogin(
              showMessage: true,
              messageContent:
                  "A reset link has been sent. Check your email.")));
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "The link was not sent. Try again.",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 300,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "A password reset link will be sent to your registered email.",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.text,
              controller: _emailController,
              decoration: InputDecoration(
                  fillColor: const Color.fromARGB(255, 31, 31, 31),
                  filled: true,
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 191, 82, 43))),
                  // ignore: sized_box_for_whitespace
                  label: Container(
                    width: 70,
                    child: const Row(
                      children: [
                        Icon(
                          Icons.email,
                          size: 15,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Email",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)))),
            ),
          ),
          GestureDetector(
            onTap: (){
              sendResetPasswordLink(context);
            }, //Function call
            child: Container(
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.all(Radius.circular(15))),
              child: Center(
                child: Text(
                  "Send link",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
