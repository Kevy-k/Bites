import 'package:bites/User/Provider/order_payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder<Map<String, Map<String, dynamic>>>(
            future: Provider.of<OrderPaymentProvider>(context, listen: false)
                .retrieveOrders(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text("Something went wrong"));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                    child: Text("Looks like you haven't ordered yet"));
              } else {
                final orders = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    String orderId = orders.keys.elementAt(index);
                    Map<String, dynamic> order = orders[orderId]!;

                    List<dynamic> items = order['items'];
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
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  Text("Order ID: $orderId",style: TextStyle(fontSize: 15,color: Colors.green[700]),),
                                ],
                              ),
                              
                            ),Divider(indent: 20,color: Theme.of(context).colorScheme.primary,),
                            ...items.map((item) {
                              dynamic Price=item['Price']*item['Quantity'];
                              print(Price);
                              return ListTile(
                                title: Text(item["ItemName"]+" ("+item['Quantity'].toString()+")",),
                                trailing: Text("₹ $Price",style: const TextStyle(fontSize: 14)),
                              );
                            }),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  
                                  Text("Total Price: ₹${order['totalPrice']}",style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 17,),),
                                ],

                              ),
                            ),
                        const  Text("Approximate Time: 20-30 mins"),
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