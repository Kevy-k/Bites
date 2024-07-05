import 'package:bites/User/Provider/userInstance.dart';
import 'package:bites/Vendor/Provider/vendor_restaurant_provider.dart';
import 'package:bites/Vendor/add_restaurant.dart';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

class VendorHomePage extends StatefulWidget {
  const VendorHomePage({super.key});

  @override
  State<VendorHomePage> createState() => _VendorHomePageState();
}

class _VendorHomePageState extends State<VendorHomePage> {
  @override
  void initState() {
    Provider.of<VendorRestaurantProvider>(context, listen: false)
        .checkRestaurantAvailability();
    Provider.of<UserProfile>(context,listen: false).getUsername();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<VendorRestaurantProvider>(
                builder: (context, value, child) {
              if (value.addedRestaurant) {
                return Column(
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: Image.network(value.restaurant['Img']),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        height: 170,
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    value.restaurant['Name'],
                                    style: TextStyle(
                                        color:
                                            Theme.of(context).colorScheme.tertiary,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  value.restaurant['Type'] == "veg"
                                      ? const Icon(
                                          Icons.circle_rounded,
                                          size: 10,
                                          color: Colors.green,
                                        )
                                      : value.restaurant['Type'] == "non-veg"
                                          ? const Icon(
                                              Icons.circle_rounded,
                                              size: 10,
                                              color: Colors.red,
                                            )
                                          : const Icon(
                                              Icons.circle_rounded,
                                              size: 10,
                                              color: Colors.green,
                                            ),
                                  // Text(
                                  //   "|",
                                  //   style: TextStyle(
                                  //       color:
                                  //           Theme.of(context).colorScheme.tertiary),
                                  // ),
                                  // const Icon(
                                  //   Icons.circle_rounded,
                                  //   size: 10,
                                  //   color: Colors.red,
                                  // ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color:
                                              Theme.of(context).colorScheme.primary,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      width: 50,
                                      height: 30,
                                      child: Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              size: 18,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiary,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              value.restaurant['Rating'],
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .tertiary),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    value.restaurant['City'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Theme.of(context).colorScheme.tertiary),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    value.restaurant['Catagory'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Theme.of(context).colorScheme.tertiary),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                              Row(
                                children: [
                                  const Text("License : Active"),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.verified_user_rounded,
                                        color:
                                            Theme.of(context).colorScheme.primary,
                                      ),
                                      Text(
                                        "Assured",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
               else {
                return Column(
                  children: [
                    const SizedBox(
                      height: 300,
                    ),
                 
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                Theme.of(context).colorScheme.tertiary)),
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => AddRestaurant())),
                        child: const Icon(
                          Icons.add_business_rounded,
                          size: 25,
                        ))
                  ],
                );
              }
            }),
            //Restaurant Details
            const SizedBox(
              height: 20,
            ),
            Consumer<VendorRestaurantProvider>(
                builder: (context, value, child) {
              if (value.addedRestaurant) {
                return Container(
                  height: 500,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 150,
                              width: 180,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                color: Theme.of(context).colorScheme.background,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    blurRadius: 5,
                                  )
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Total Revenue",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    "Rs 2000",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                        fontSize: 18),
                                  )
                                ],
                              ),
                            )
                                .animate()
                                .fadeIn(
                                  duration: Duration(seconds: 1),
                                  begin: 0,
                                )
                                .slideY(),
                            Container(
                              height: 150,
                              width: 180,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                color: Theme.of(context).colorScheme.background,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    blurRadius: 5,
                                  )
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Total Orders",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    "46",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                        fontSize: 18),
                                  )
                                ],
                              ),
                            )
                                .animate()
                                .fadeIn(
                                  duration: Duration(seconds: 1),
                                  begin: 0,
                                )
                                .slideY(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 150,
                              width: 180,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                color: Theme.of(context).colorScheme.background,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    blurRadius: 5,
                                  )
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Menu Items",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    "0",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                        fontSize: 18),
                                  )
                                ],
                              ),
                            )
                                .animate()
                                .fadeIn(
                                  duration: Duration(milliseconds: 500),
                                  begin: 0,
                                )
                                .slideY(),
                            Container(
                              height: 150,
                              width: 180,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                color: Theme.of(context).colorScheme.background,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    blurRadius: 5,
                                  )
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "User Feedback",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    "5",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                        fontSize: 18),
                                  )
                                ],
                              ),
                            )
                                .animate()
                                .fadeIn(
                                  duration: Duration(milliseconds: 500),
                                  begin: 0,
                                )
                                .slideY(),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              } 
              else {
                return const Center(
                  child: Text("Add your restaurant",style: TextStyle(fontSize: 15),),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
