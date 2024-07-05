import 'package:bites/Vendor/Provider/menuProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:provider/provider.dart';

class AddMenu extends StatefulWidget {
  const AddMenu({super.key});

  @override
  State<AddMenu> createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {
  final _formKey = GlobalKey<FormBuilderState>();
  final itemName = TextEditingController();
  final price = TextEditingController();
  final type = TextEditingController();

@override
  void dispose() {
    itemName.dispose();
    price.dispose();
    type.dispose();
    super.dispose();
  }

  Future<void> _addMenu(BuildContext context) async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState?.value;
      final itemName = formData?['ItemName'];
      final price = formData?['Price'];
      final type = formData?['type'];
      final fileList = formData?['attachments'] as List<PlatformFile>;
      final file = fileList.first;
      int itemPrice=int.parse(price);

      final provider = Provider.of<MenuProvider>(context, listen: false);
      try {
        if (await provider.addMenus(itemName, itemPrice, type, file)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Menu added",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.background),
              ),
              backgroundColor: Theme.of(context).colorScheme.tertiary,
            ),
          );
          dispose();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Failed to add item",
                style: TextStyle(color: Colors.red[700]),
              ),
              backgroundColor: Theme.of(context).colorScheme.tertiary,
            ),
          );
          dispose();

        }
      } catch (e) {
        print(e);
        throw ();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.tertiary,
                      blurRadius: 12,
                    )
                  ],
                ),
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
                            "Add Menu",
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
                                    name: "ItemName",
                                    keyboardType: TextInputType.text,
                                    controller: itemName,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                        fillColor: const Color.fromARGB(
                                            255, 31, 31, 31),
                                        filled: true,
                                        label: Text(
                                          "Item Name",
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 191, 82, 43)),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
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
                                    name: "Price",
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true, signed: false),
                                    controller: price,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                        fillColor: const Color.fromARGB(
                                            255, 31, 31, 31),
                                        filled: true,
                                        label: Text(
                                          "Price",
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 191, 82, 43)),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
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
                                    name: "type",
                                    keyboardType: TextInputType.emailAddress,
                                    controller: type,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                        fillColor: const Color.fromARGB(
                                            255, 31, 31, 31),
                                        filled: true,
                                        label: Text(
                                          "Type",
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 191, 82, 43)),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
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
                                          const Icon(
                                              Icons.attach_file_outlined),
                                          Text(
                                            " Item Image",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 10),

                              //checking for file uploading
                              Consumer<MenuProvider>(
                                  builder: (context, value, child) {
                                print("consumer vendor REgister Build ");
                                if (value.isuploading) {
                                  return CircularProgressIndicator(
                                    strokeCap: StrokeCap.round,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )
                                      .animate()
                                      .fade(duration: Duration(seconds: 2));
                                } else {
                                  return ElevatedButton(
                                      style: ButtonStyle(
                                          foregroundColor:
                                              WidgetStatePropertyAll(
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .background),
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .tertiary)),
                                      onPressed: () => _addMenu(context),
                                      child: const Text("Add"));
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
            ],
          ),
        ),
      ),
    );
  }
}
