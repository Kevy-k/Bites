import 'package:bites/User/Provider/login_provider.dart';
import 'package:bites/User/forgot_password.dart';
import 'package:bites/User/register.dart';
import 'package:bites/Vendor/vendor_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class UserLogin extends StatefulWidget {
  final bool showMessage;
  final String messageContent;
  const UserLogin(
      {super.key, required this.showMessage, required this.messageContent});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.showMessage) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            '${widget.messageContent}',
            style: TextStyle(color: Theme.of(context).colorScheme.background),
          ),
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          behavior: SnackBarBehavior.floating,
        ));
      }
    });
    super.initState();
  }

//User Firebase SignIn Function

//User Firebase SignIn Function

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("build1");
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
          child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 150,
              ),
              SizedBox(
                child: const Text(
                  "Welcome Back",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 191, 82, 43)),
                )
                    .animate()
                    .fade(duration: const Duration(seconds: 2))
                    .slideY(duration: const Duration(seconds: 1)),
              ),
              SizedBox(
                height: 150,
                child: Lottie.network(
                  "https://lottie.host/85da2ebf-e589-4299-a83a-02a187d6dc6f/OS71QmsMDw.json",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.text,
                        controller: _emailController,
                        decoration: InputDecoration(
                            fillColor: const Color.fromARGB(255, 31, 31, 31),
                            filled: true,
                            focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 191, 82, 43))),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        controller: _passwordController,
                        decoration: InputDecoration(
                            fillColor: const Color.fromARGB(255, 31, 31, 31),
                            filled: true,
                            focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 191, 82, 43))),
                            // ignore:sized_box_for_whitespace
                            label: Container(
                              width: 100,
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.lock,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Password",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword())),
                            child: Text(
                              "Forgot Password",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Consumer<LoginProvider>(builder: (context, value, child) {
                      if (value.isError) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                value.error,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background),
                              ),
                              backgroundColor:
                                  Theme.of(context).colorScheme.tertiary,
                              behavior: SnackBarBehavior.floating,
                            ),
                            
                          );
                          value.clearError();
                          // Make sure to clear the error after showing the Snackbar
                        });
                      }
                      if (value.waiting) {
                        return CircularProgressIndicator(
                          strokeCap: StrokeCap.round,
                          color: Theme.of(context).colorScheme.primary,
                        ).animate().fade(duration: const Duration(seconds: 2));
                      } else {
                        return GestureDetector(
                          onTap: () {
                            value.SignIn(
                                _emailController.text.trim(),
                                _passwordController.text.trim(),
                                context); //Function call
                          },
                          child: Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Center(
                              child: Text(
                                "SignIn",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        );
                      }
                    }),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Create account ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const UserRegister()),
                          ),
                          child: const Text(
                            " SignUp",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Color.fromARGB(255, 191, 82, 43),
                                fontSize: 18),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text(
                          "Want to grow your business?..",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 18),
                        ),
                      ],
                    ),
                    Divider(
                      indent: 120,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).colorScheme.tertiary,
                              blurRadius: 10,
                            )
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(22))),
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Theme.of(context).colorScheme.background),
                              shadowColor: MaterialStatePropertyAll(
                                  Theme.of(context).colorScheme.tertiary)),
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const VendorRegister())),
                          child: Row(
                            children: [
                              Icon(
                                Icons.handshake,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Partner with Bites",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.tertiary),
                              )
                            ],
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      )),
    );
  }
}
