import 'package:bites/User/user_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({super.key});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final _fnameController = TextEditingController();

  final _lnameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _phoneController = TextEditingController();

  final _confirmPassController = TextEditingController();
  final _cityController=TextEditingController();
  final _addressController=TextEditingController();
@override
  void dispose() {
   _fnameController.dispose();
  _lnameController.dispose();
   _emailController.dispose();
   _passwordController.dispose();
   _phoneController.dispose();
   _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Register",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Color.fromARGB(255, 191, 82, 43)),
              ).animate().fadeIn(duration: const Duration(seconds: 1)).slideX(),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: _fnameController,
                      decoration: InputDecoration(
                          fillColor: Color.fromARGB(255, 31, 31, 31),
                          filled: true,
                          label: Text(
                            "First Name",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 191, 82, 43)),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: _lnameController,
                      decoration: InputDecoration(
                          fillColor: const Color.fromARGB(255, 31, 31, 31),
                          filled: true,
                          label: Text(
                            "Last Name",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 191, 82, 43)),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: InputDecoration(
                          fillColor: Color.fromARGB(255, 31, 31, 31),
                          filled: true,
                          label: Text(
                            "Email",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 191, 82, 43)),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: _phoneController,
                      decoration: InputDecoration(
                          fillColor: Color.fromARGB(255, 31, 31, 31),
                          filled: true,
                          label: Text(
                            "Phone",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 191, 82, 43)),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      
                      style: const TextStyle(color: Colors.white),
                      controller: _cityController,
                      decoration: InputDecoration(
                          fillColor: Color.fromARGB(255, 31, 31, 31),
                          filled: true,
                          hintText: "You can change this later",
                          hintStyle: TextStyle(color: Colors.grey),
                          label: Text(
                            "City",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 191, 82, 43)),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                    maxLines: 3,
                      style: const TextStyle(color: Colors.white),
                      controller: _addressController,
                      decoration: InputDecoration(
                          fillColor: Color.fromARGB(255, 31, 31, 31),
                          filled: true,
                          hintText: "Enter your full address. You can change this later",
                          hintStyle: TextStyle(color: Colors.grey),
                          label: Text(
                            "Address",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 191, 82, 43)),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                          fillColor: Color.fromARGB(255, 31, 31, 31),
                          filled: true,
                          label: Text(
                            "Create Password",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 191, 82, 43)),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      controller: _confirmPassController,
                      decoration: InputDecoration(
                        fillColor: Color.fromARGB(255, 31, 31, 31),
                        filled: true,
                        alignLabelWithHint: true,
                        label: Text(
                          "Confirm Password",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 191, 82, 43)),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GestureDetector(
                      onTap: signUp,
                      child: const Text(
                        "SignUp",
                        style: TextStyle(color: Colors.green, fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      GestureDetector(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const UserLogin(
                                      showMessage: false,
                                      messageContent: "",
                                    ))),
                        child: const Text(
                          " SignIn",
                          style: TextStyle(
                              color: Color.fromARGB(255, 191, 82, 43),
                              fontSize: 18,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  bool checkPassword() {
    if (_passwordController.text.trim() == _confirmPassController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  Future signUp() async {
    if (_confirmPassController.text.trim() != "" &&
        _fnameController.text.trim() != "" &&
        _lnameController.text.trim() != "" &&
        _emailController.text.trim() != "" &&
        _cityController.text.trim()!=""&&
        _addressController.text.trim()!=""&&
        _passwordController.text.trim() != "") {
      if (checkPassword()) {
        try {
         UserCredential userCred= await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim());

          addUser(_fnameController.text.trim(), _lnameController.text.trim(),
              _emailController.text.trim(), _phoneController.text.trim(),_cityController.text.trim(),_addressController.text.trim(),userCred);

          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const UserLogin(
                    showMessage: true,
                    messageContent: "Account created successfully",
                  )));
        
        } on FirebaseAuthException catch (e) {
          // ignore: avoid_print
          print(e);
          showMessage("Failed to create account. Try again");
        }
      } else {
        showMessage("Password Mismatch");
      }
    } else {
      showMessage("All fields are required");
    }
  }

  Future addUser(String fname, String lname, String email, String ph,String city,String address,UserCredential u) async {
    await FirebaseFirestore.instance.collection("users").doc(u.user?.uid).set({
      'first name': fname,
      'last name': lname,
      'email': email,
      'phone': ph,
      'city':city,
      'address':address,
      'rights':"user"
    });
  }

  void showMessage(String x) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          x,
          style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.background),
        ),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
