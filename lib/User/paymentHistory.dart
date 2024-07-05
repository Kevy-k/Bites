import 'package:bites/User/Provider/order_payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentHistory extends StatelessWidget {
  const PaymentHistory({super.key});

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
                          
                          color: Theme.of(context).colorScheme.secondary,
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
                              dynamic Price=item['Price']*item['Quantity'];
                              print(Price);
                              return ListTile(
                                title: Text(item["ItemName"]+" ("+item['Quantity'].toString()+")",style: TextStyle(color:Colors.black,),),
                                trailing: Text("₹ $Price",style: TextStyle(color:Colors.green[700],fontSize: 14)),
                              );
                            }),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  Text("Total Price: ₹${order['totalPrice']}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.green[700]),),
                                ],
                              ),
                            )
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
