import 'package:bites/Admin/Provider/addSpecial_Provider.dart';
import 'package:bites/Admin/adminDrawer.dart';
import 'package:bites/Admin/vendor_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:provider/provider.dart';

class AddSpecials extends StatefulWidget {
  const AddSpecials({super.key});

  @override
  State<AddSpecials> createState() => _AddSpecialsState();
}

class _AddSpecialsState extends State<AddSpecials> {
 final _formKey = GlobalKey<FormBuilderState>();
 final itemName=TextEditingController();

@override
  void dispose() {
    itemName.dispose();
    super.dispose();
  }
Future<void>add()async{
  if(_formKey.currentState?.saveAndValidate()??false){
    final formData=_formKey.currentState?.value;
    final itemName=formData?['ItemName'];
    final fileList=formData?['attachments'] as List<PlatformFile>;
    final file=fileList.first;
    final provider=Provider.of<SpecialsProvider>(context,listen: false);
    try{
        if(await provider.addSpecials(itemName, file)){
            ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Item added to specials",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.background),
              ),
              backgroundColor: Theme.of(context).colorScheme.tertiary,
            ),
          );
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const VendorRequests()));
        
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Failed to add item",
                style: TextStyle(color: Colors.red[700]),
              ),
              backgroundColor: Theme.of(context).colorScheme.tertiary,
            ),
          );

        }

    }catch(e){
      throw();
    }
  }else{

  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "Add Specials",
          style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
        ),
        centerTitle: true,
      ),
      drawer: AdminPanel(),
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
                            "Add Specials",
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
                              Consumer<SpecialsProvider>(
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
                                      onPressed: (){
                                        add();
                                      },
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