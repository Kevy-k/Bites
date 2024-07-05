import 'package:bites/Vendor/Provider/vendor_restaurant_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantOrders extends StatelessWidget {
  const RestaurantOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder<Map<String, Map<String, dynamic>>>(
            future: Provider.of<VendorRestaurantProvider>(context, listen: false)
                .retrieveOrders(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text("Something went wrong"));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                    child: Text("Looks like there are no orders yet"));
              } else {
                final orders = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    String orderId = orders.keys.elementAt(index);
                    Map<String, dynamic> order = orders[orderId]!;

                    List<dynamic> items = order['Items'];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          
                          color: Theme.of(context).colorScheme.background,
                          borderRadius:
                              const BorderRadius.all(Radius.elliptical(20, 20)),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).colorScheme.tertiary,
                              blurRadius: 5,
                            )
                          ],
                        ),
                        child: Column(

                          children: [
                            ...items.map((item) {
                              return ListTile(
                                title: Text(item["ItemName"],style:const TextStyle(),),
                                trailing: Text(item['Quantity'].toString(),style: TextStyle(fontSize: 14)),
                              );
                            }),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                Text("Address: ${order['Address']}"),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20,)
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}