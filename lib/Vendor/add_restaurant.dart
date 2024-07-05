import 'package:bites/Vendor/Provider/vendor_restaurant_provider.dart';
import 'package:bites/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

class AddRestaurant extends StatefulWidget {
  AddRestaurant({super.key});

  @override
  State<AddRestaurant> createState() => _AddRestaurantState();
}

class _AddRestaurantState extends State<AddRestaurant> {
  final _name = TextEditingController();

  final _city = TextEditingController();

  final _district = TextEditingController();

  final _state = TextEditingController();

  final _landmark = TextEditingController();

  final _pincode = TextEditingController();

  final _phone = TextEditingController();

  final _catagory = TextEditingController();

  final _type = TextEditingController();

  final _rating = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _city.dispose();
    _phone.dispose();
    _pincode.dispose();
    _district.dispose();
    _state.dispose();
    _catagory.dispose();
    _type.dispose();
    _rating.dispose();
    _landmark.dispose();
    super.dispose();
  }

  Future<void> add(context) async {
    try {
      if (await Provider.of<VendorRestaurantProvider>(context, listen: false)
          .addRestaurant(
              name: _name.text.trim(),
              city: _city.text.trim(),
              pincode: _pincode.text.trim(),
              district: _district.text.trim(),
              landmark: _landmark.text.trim(),
              state: _state.text.trim(),
              phone: _phone.text.trim(),
              catagory: _catagory.text.trim(),
              type: _type.text.trim(),
              rating: _rating.text.trim())) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MainPage()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Failed to add restaurant. Try again",
              style: TextStyle(color: Colors.red[700]),
            ),
            backgroundColor: Theme.of(context).colorScheme.tertiary,
          ),
        );
      }
    } catch (e) {
      throw ();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Text(
                "Add Restaurant",
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
                      controller: _name,
                      decoration: InputDecoration(
                          fillColor: Color.fromARGB(255, 31, 31, 31),
                          filled: true,
                          label: Container(
                            width: 180,
                            child: Row(
                              children: [
                                const Icon(Icons.restaurant),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Restaurant Name",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ],
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
                      controller: _city,
                      decoration: InputDecoration(
                          fillColor: const Color.fromARGB(255, 31, 31, 31),
                          filled: true,
                          label: Container(
                            width: 80,
                            child: Row(
                              children: [
                                const Icon(Icons.location_city_rounded),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "City",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ],
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
                      controller: _pincode,
                      decoration: InputDecoration(
                        fillColor: Color.fromARGB(255, 31, 31, 31),
                        filled: true,
                        alignLabelWithHint: true,
                        label: Container(
                          width: 100,
                          child: Row(
                            children: [
                              const Icon(Icons.pin_drop),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Pincode",
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ],
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
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                      controller: _district,
                      decoration: InputDecoration(
                          fillColor: Color.fromARGB(255, 31, 31, 31),
                          filled: true,
                          label: Container(
                            width: 100,
                            child: Row(
                              children: [
                                const Icon(Icons.place),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "District",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ],
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
                      controller: _landmark,
                      decoration: InputDecoration(
                          fillColor: Color.fromARGB(255, 31, 31, 31),
                          filled: true,
                          label: Container(
                            width: 120,
                            child: Row(
                              children: [
                                const Icon(Icons.delivery_dining),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Landmark",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ],
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
                      controller: _state,
                      decoration: InputDecoration(
                          fillColor: Color.fromARGB(255, 31, 31, 31),
                          filled: true,
                          label: Container(
                            width: 120,
                            child: Row(
                              children: [
                                const Icon(Icons.location_on),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "State",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ],
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
                      controller: _phone,
                      decoration: InputDecoration(
                        fillColor: Color.fromARGB(255, 31, 31, 31),
                        filled: true,
                        alignLabelWithHint: true,
                        label: Container(
                          width: 120,
                          child: Row(
                            children: [
                              const Icon(Icons.phone),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Phone",
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ],
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
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: _catagory,
                      decoration: InputDecoration(
                        fillColor: Color.fromARGB(255, 31, 31, 31),
                        filled: true,
                        alignLabelWithHint: true,
                        hintText: "Ex. juices,meals...",
                        label: Container(
                          width: 120,
                          child: Row(
                            children: [
                              const Icon(Icons.menu_book),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Catagory",
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ],
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
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: _type,
                      decoration: InputDecoration(
                        fillColor: Color.fromARGB(255, 31, 31, 31),
                        filled: true,
                        alignLabelWithHint: true,
                        hintText: "Veg, Non-veg, Both",
                        label: Container(
                          width: 80,
                          child: Row(
                            children: [
                              Text(
                                "Type",
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ],
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
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: _rating,
                      decoration: InputDecoration(
                        fillColor: Color.fromARGB(255, 31, 31, 31),
                        filled: true,
                        alignLabelWithHint: true,
                        hintText: "based on your license",
                        label: Container(
                          width: 100,
                          child: Row(
                            children: [
                              const Icon(Icons.star_rounded),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Rating",
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ],
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
                  Consumer<VendorRestaurantProvider>(
                      builder: (context, value, child) {
                    if (value.waiting) {
                      return const CircularProgressIndicator(
                        strokeCap: StrokeCap.round,
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: GestureDetector(
                          onTap: () {
                            add(context);
                          },
                          child: const Text(
                            "Add",
                            style: TextStyle(color: Colors.green, fontSize: 20),
                          ),
                        ),
                      );
                    }
                  }),
                  const SizedBox(
                    height: 10,
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
}
