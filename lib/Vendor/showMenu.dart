import 'package:bites/Vendor/Provider/vendor_restaurant_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowMenu extends StatelessWidget {
  const ShowMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
                stream: Provider.of<VendorRestaurantProvider>(context, listen: false)
                    .showMenu(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text("Failed to fetch menu details");
                  } else {
                    Map<String, Map<String, dynamic>> menus =
                        snapshot.data ?? {};
                    return Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: menus.length,
                          itemBuilder: (context, index) {
                            String menuId = menus.keys.elementAt(index);
                            Map<String, dynamic> menu = menus[menuId]!;
                            return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.tertiary,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15))),
                                height: 150,
                                width: 400,
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 12.0),
                                          child: SizedBox(
                                            height: 120,
                                            width: 150,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              child: Image.network(
                                                menu['ItemImage'],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 200,
                                        )
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          menu['ItemName'],
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .background),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Rs. ${menu['Price'].toString()}',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
