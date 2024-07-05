import 'package:bites/User/user_login.dart';
import 'package:bites/Vendor/Provider/vendorRegister_Provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:provider/provider.dart';

class VendorRegister extends StatefulWidget {
  const VendorRegister({super.key});

  @override
  State<VendorRegister> createState() => _VendorRegisterState();
}

class _VendorRegisterState extends State<VendorRegister> {
  final _formKey = GlobalKey<FormBuilderState>();
  final ownerName = TextEditingController();
  final licenseId = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  //vendor register
  Future<void> _registerVendor(BuildContext context) async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState?.value;
      final ownerNameValue = formData?['ownerName'];
      final licenseIdValue = formData?['licenseId'];
      final emailValue = formData?['email'];
      final phoneValue = formData?['phone'];
      final passwordValue = formData?['password'];
      final files = formData?['attachments'] as List<PlatformFile>;

      final provider =
          Provider.of<VendorRegisterProvider>(context, listen: false);
      try {
        if (await provider.registerVendor(ownerNameValue, licenseIdValue,
            emailValue, phoneValue, passwordValue, files)) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const UserLogin(
                  showMessage: true,
                  messageContent: "Account will be created soon")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Registration failed",
                style: TextStyle(color: Colors.red[700]),
              ),
              backgroundColor: Theme.of(context).colorScheme.tertiary,
            ),
          );
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print("vendor REgister Build ");
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Stack(
            children: [
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      "Grow your business with Bites",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Color.fromARGB(255, 191, 82, 43)),
                    )
                        .animate()
                        .fadeIn(duration: const Duration(seconds: 1))
                        .slideX(),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: FormBuilderTextField(
                              name: "ownerName",
                              keyboardType: TextInputType.text,
                              controller: ownerName,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  fillColor:
                                      const Color.fromARGB(255, 31, 31, 31),
                                  filled: true,
                                  label: Text(
                                    "Owner Name",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 191, 82, 43)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15)))),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: FormBuilderTextField(
                              name: "licenseId",
                              keyboardType: TextInputType.text,
                              controller: licenseId,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  fillColor:
                                      const Color.fromARGB(255, 31, 31, 31),
                                  filled: true,
                                  label: Text(
                                    "License ID",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 191, 82, 43)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15)))),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: FormBuilderTextField(
                              name: "email",
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  fillColor:
                                      const Color.fromARGB(255, 31, 31, 31),
                                  filled: true,
                                  label: Text(
                                    "Email",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 191, 82, 43)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15)))),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: FormBuilderTextField(
                              name: "password",
                              keyboardType: TextInputType.text,
                              controller: passwordController,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  fillColor:
                                      const Color.fromARGB(255, 31, 31, 31),
                                  filled: true,
                                  label: Text(
                                    "Password",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 191, 82, 43)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15)))),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: FormBuilderTextField(
                              name: "phone",
                              keyboardType: TextInputType.text,
                              controller: phoneController,
                              decoration: InputDecoration(
                                  fillColor:
                                      const Color.fromARGB(255, 31, 31, 31),
                                  filled: true,
                                  label: Text(
                                    "Phone",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 191, 82, 43)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15)))),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FormBuilderFilePicker(
                          name: "attachments",
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          )),
                          maxFiles: null,
                          previewImages: true,
                          withData: true,
                          typeSelectors: [
                            TypeSelector(
                              type: FileType.image,
                              selector: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Icon(Icons.attach_file_outlined),
                                    Text(
                                      " Business Image",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            TypeSelector(
                              type: FileType.any,
                              selector: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Icon(Icons.attach_file_outlined),
                                    Text(
                                      " License Proof",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(
                          "Your account will be created once confirmed by the admin",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary),
                        ),
                          const SizedBox(height: 10),

                        //checking for file uploading
                        Consumer<VendorRegisterProvider>(
                            builder: (context, value, child) {
                                print("consumer vendor REgister Build ");
                              if(value.isuploading){
                                return CircularProgressIndicator(
                                  strokeCap: StrokeCap.round,
                            color: Theme.of(context).colorScheme.primary,
                          ).animate().fade(duration: Duration(seconds: 2));
                              }
                              else{
                                return  ElevatedButton(
                            style: ButtonStyle(
                                foregroundColor: WidgetStatePropertyAll(
                                    Theme.of(context).colorScheme.tertiary),
                                backgroundColor: WidgetStatePropertyAll(
                                    Theme.of(context).colorScheme.primary)),
                            onPressed: () => _registerVendor(context),
                            
                            child: const Text("Apply"));
                              }
                          
                        }),
                      
                       
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
