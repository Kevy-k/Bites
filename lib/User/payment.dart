import 'package:bites/User/Provider/menu_cart_provider.dart';
import 'package:bites/User/Provider/order_payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key, required this.total});
  final num total;
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Razorpay razorpay = Razorpay();
  


  void _handlePaymentSuccess(PaymentSuccessResponse response)async {
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:const Text(
          "Paymeny Successfull",
          style:TextStyle(color:  Colors.green),
        ),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
      ),
    );

   await Provider.of<OrderPaymentProvider>(context,listen: false).placeOrder(widget.total.toString());
   await Provider.of<OrderPaymentProvider>(context,listen: false).distributeOrdersToRestaurants(context);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Payment Failed",
          style: TextStyle(color: Colors.red[700]),
        ),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
      ),
    ); // Do something when payment fails
  }
  @override
  void dispose() {
    
    super.dispose();
    try{
      razorpay.clear();
    }catch(e){

    }
  }

  @override
  Widget build(BuildContext context) {
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text("Confirm Payment"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 50.0),
              child: ListTile(
                  title: Text(
                    "Item",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  trailing: SizedBox(
                    width: 200,
                    child: Row(
                      children: [
                        Text(
                          "Price",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 35,
                        ),
                        Text(
                          "Qty",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 35,
                        ),
                        Text(
                          "Total",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 15),
              child: Container(
                  height: 600,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius:
                        const BorderRadius.all(Radius.elliptical(40, 40)),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.tertiary,
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: StreamBuilder(
                    stream:
                        Provider.of<MenuAndCartProvider>(context, listen: false)
                            .getMyCart(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return const Center(
                            child: Text(
                                "Looks like there was an error.Try again"));
                      } else if (snapshot.data!.isEmpty) {
                        return const Center(child: Text("Your cart is empty"));
                      }
                      Map<String, Map<String, dynamic>> cartItems =
                          snapshot.data ?? {};
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.separated(
                            separatorBuilder: (context, index) => Divider(
                                  color: Colors.black,
                                ),
                            itemCount: cartItems.length,
                            itemBuilder: (context, index) {
                              var cartId = cartItems.keys.elementAt(index);
                              Map<String, dynamic> cart = cartItems[cartId]!;
                              var totalItemPrice =
                                  cart['Price'] * cart['Quantity'];
                              return ListTile(
                                  leading: Text('${index + 1}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      )),
                                  title: Text(
                                    cart['ItemName'],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                  trailing: SizedBox(
                                    width: 200,
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        Text(
                                          cart['Price'].toString(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 50,
                                        ),
                                        Text(
                                          cart['Quantity'].toString(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 50,
                                        ),
                                        Text(
                                          totalItemPrice.toString(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                  ));
                            }),
                      );
                    },
                  )),
            ),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.primary),
                  foregroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.tertiary),
                ),
                onPressed: () {
                  
                  var options = {
                    
                    'key': 'rzp_test_K2pEO3CZR3jcNQ',
                    'amount': Provider.of<MenuAndCartProvider>(context,listen: false).totalprice*100,
                    'name': 'Bites',
                    'description':'Cart Checkout' ,
                    'prefill': {
                      'email': 'test@razorpay.com'
                    }
                  };
                  razorpay.open(options);
                },
                child: Text(
                  "Pay  ₹${widget.total}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
